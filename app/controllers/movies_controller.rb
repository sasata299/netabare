class MoviesController < ApplicationController
  caches_page :index, :youtube

  def index
    @movie = Movie.paginate(
      :all, 
      :order    => ["updated_at DESC, id DESC"],
      :page     => params[:page],
      :per_page => 25
    )

    if @movie.empty?
      redirect_to root_path
      return
    end
  end

  def youtube
    @movie = Movie.find(params[:id])
    render :layout => false
  end
end
