class NetabaresController < ApplicationController
  caches_page :show

  def show
    @netabare = Netabare.find_all_by_movie_id(params[:id], :include => "movie")
    render :layout => false
  end
end
