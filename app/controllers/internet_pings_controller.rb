class InternetPingsController < ApplicationController
  def index
    @search = PingLog.where(:ping_type => "Domain").search(params[:search] || {"meta_sort" => 'id.asc'})
    @internet_pings = @search.paginate(:page => params[:page]).all
    @domains ||= Domain.all
  end
end
