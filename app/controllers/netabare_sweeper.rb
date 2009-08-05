class NetabareSweeper < ApplicationController::Caching::Sweeper
  observer Netabare

  def after_save(record)
    expire_page :controller => "netabares", :action => "show", :id => record.id
  end
end
