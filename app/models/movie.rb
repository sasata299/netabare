class Movie < ActiveRecord::Base
  require 'scrapi'
  require 'RMagick'
  require 'open-uri'
  require 'rexml/document'
  require 'uri'
  require 'mechanize'
  require 'extractcontent'
  require 'jcode'

  SCRAPE_URL     = 'http://cinesc.cplaza.ne.jp/'
  AMAZON_API_URL = 'http://gdata.youtube.com/feeds/api/videos'

  def self.get_movie_info
    data = Scraper.define do
      process "div#TOPtheater > div.theater > div.pic img",  "urls[]"   => "@src"
      process "div#TOPtheater > div.theater > div.detail a", "titles[]" => :text
      result :urls, :titles
    end.scrape( URI.parse(SCRAPE_URL), :parser_options => {:char_encoding => 'shiftjis'} )

    data[:titles].map!{|d|
      d.kconv(Kconv::UTF8, Kconv::SJIS)
    }

    @@last = data[:titles].size - 1
    return data
  end

  def self.store_image(data)
    data[:urls].each do |img|
      begin
        target = File.dirname(__FILE__) + '/../../public/images/' + img.split('/')[-1]

        mimage = Magick::ImageList.new(SCRAPE_URL + img)
        mimage.write(target) unless File.file?(target)
      rescue => error
        puts error
        return false
      end
    end
    return true
  end

  def self.store_in_db(data)
    (0..@@last).reverse_each do |index|
      attributes = {
        :name  => data[:titles][index],
        :image => data[:urls][index].split('/')[-1],
      }

      tmp_array = [ data[:titles][index], "予告編" ]
      query = AMAZON_API_URL + "?format=5&lr=ja&vq=" + tmp_array.map!{|q| URI.escape(q)}.join("+")
      result = open(query)

      doc = REXML::Document.new(result)

      other_attributes = {}
      doc.elements.each("feed/entry/media:group/media:content") do |element|
        other_attributes = {
          :ytype => element.attributes['type'],
          :yurl  => element.attributes['url'],
        }
        break if element.attributes['type'] and element.attributes['url']
      end

      attributes.merge!(other_attributes)

      db = self.find_by_name(data[:titles][index])
      if db
        attributes.merge!({:updated_at => Time.now})
        self.update(db.id, attributes)
      else
        self.create(attributes)
      end
    end
  end
end

