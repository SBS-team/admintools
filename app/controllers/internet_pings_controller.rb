class InternetPingsController < ApplicationController
  def index
    @search = PingLog.where(:ping_type => "Domain").search(params[:search] || {"meta_sort" => 'status.desc'})
    @internet_pings = @search.paginate(:page => params[:page]).all
    @domains ||= Domain.all
  end
end
