class InternetPingsController < ApplicationController

  def index
    @internet_pings = PingLog.where(:ping_type => "Domain").paginate(:page => params[:page]).all#.search(params[:search] || {"meta_sort" => 'id.asc'})
    #@internet_pings = @search.paginate(:page => params[:page]).all
  end

end
