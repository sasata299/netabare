class MoviesController < ApplicationController
  def index
    @movie = Movie.find(:all, :order => ["updated_at DESC"])
  end

  def youtube
    @movie = Movie.find(params[:id])
    render :layout => false
  end
end
