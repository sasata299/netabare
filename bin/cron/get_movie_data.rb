#!/usr/bin/ruby

require 'rubygems'
require 'active_record'
$:.push(File.dirname(__FILE__) + "/../../app/models")
require 'movie'
require 'netabare'

config = YAML.load_file(File.dirname(__FILE__) + "/../../config/database.yml")
ActiveRecord::Base.establish_connection( config["development"] )
ActiveRecord::Base.logger=Logger.new(STDOUT)

$KCODE = 's'

data = Movie.get_movie_info

$KCODE = 'u'

Movie.store_image(data)
Movie.store_in_db(data)

data = Movie.find(:all, :order => "updated_at DESC", :limit => 25)
Netabare.search_from_google(data)
