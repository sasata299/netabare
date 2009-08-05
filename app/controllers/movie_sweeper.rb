class MovieSweeper < ApplicationController::Caching::Sweeper
  observer Movie

  def after_save(record)
    expire_page :controller => "movies", :action => "index"
    expire_page :controller => "movies", :action => "youtube", :id => record.id
  end
end
