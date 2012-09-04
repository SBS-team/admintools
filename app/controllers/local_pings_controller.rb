class LocalPingsController < ApplicationController
  def index
    @pings = Desktop.all 
  end

  def show 
    @desktop = Desktop.find_by_ip(params[:ip])
    @pings = @desktop.local_pings.where(:up => Time.now.utc.midnight..Time.now.utc.end_of_day)
  end
end