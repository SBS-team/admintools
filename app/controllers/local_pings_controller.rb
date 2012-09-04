class LocalPingsController < ApplicationController
  def index
    @pings = Desktop.all 
  end

  def show 
    @desktop = Desktop.find_by_ip(params[:ip])
  end
end