#!/usr/bin/ruby

ENV["RAILS_ENV"] ||= 'production'

require 'rubygems'
require 'active_record'
$:.push(File.dirname(__FILE__) + "/../../app/models")
require 'movie'

config = YAML.load_file(File.dirname(__FILE__) + "/../../config/database.yml")
ActiveRecord::Base.establish_connection(config[ENV["RAILS_ENV"]])
ActiveRecord::Base.logger=Logger.new(STDOUT)

system "rm -rf /var/www/netabare/public/cache/*"
system "wget -O /dev/null http://netaru.sasata299.com/"

movies = Movie.find(:all)
movies.each do |movie|
  url_1 = "http://netaru.sasata299.com/movie/#{movie.id}"
  url_2 = "http://netaru.sasata299.com/netabares/show/#{movie.id}"
  system "wget -O /dev/null #{url_1}"
  system "wget -O /dev/null #{url_2}"
end
