class MoviesController < ApplicationController
  def index
    @movie = Movie.paginate(:all, :page => params[:page], :per_page => 25, :order => ["updated_at DESC"])
  end

  def youtube
    @movie = Movie.find(params[:id])
    render :layout => false
  end
end
