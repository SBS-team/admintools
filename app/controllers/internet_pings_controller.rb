class InternetPingsController < ApplicationController
  before_filter :domains_all, :only => [:index]

  def index
    @search = PingLog.where(:ping_type => "Domain").search(params[:search] || {"meta_sort" => 'id.asc'})
    @internet_pings = @search.paginate(:page => params[:page]).all
  end

  def show
  end

  private

  def domains_all
    @domains ||= Domain.all
  end

end
