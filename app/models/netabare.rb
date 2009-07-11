class Netabare < ActiveRecord::Base
  belongs_to :movie

  require 'mechanize'
  require 'extractcontent'
  require 'jcode'

  def self.search_from_google(data)
    agent = WWW::Mechanize.new
    search_top = agent.get('http://www.google.co.jp')
    data.each do |d|
      search_top.forms[0].fields.name("q").value = 
        (d.name + ' ネタバレ注意"').kconv(Kconv::SJIS, Kconv::UTF8)
      result_page = search_top.forms[0].submit
      result_page.links.each do |link|
        unless /(?:google\.co|^http:\/\/74\.125|^\/)/ =~ link.href
          body,title = '',''

          begin
            one_blog = agent.get(link.href)
            body,title = ExtractContent.analyse(one_blog.body.toutf8)
          rescue TimeoutError => error
            puts error.message
          rescue => another_error
            puts another_error.message
          end
          body.gsub!(/^.*(ネタバレ.*)$/u) { $1 }

          attributes = {
            :name     => link.text.kconv(Kconv::UTF8, Kconv::SJIS),
            :url      => link.href,
            :body     => body,
            :movie_id => d.id,
          }

          db = self.find(:first, :conditions => ["url = :url and movie_id = :movie_id", {:url => link.href, :movie_id => d.id}])
          if db
            attributes.merge!({:updated_at => Time.now})
            self.update(db.id, attributes)
          else
            self.create(attributes)
          end
        end
      end
    end
  end
end
