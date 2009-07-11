class NetabaresController < ApplicationController
  def show
    @netabare = Netabare.find_all_by_movie_id(params[:id], :include => "movie")
    render :layout => false
  end
end
