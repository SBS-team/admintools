class LocalPingsController < ApplicationController
  before_filter :meta_search_params

  def index
    @network = Subnetwork.new
    @networks = Subnetwork.all
    @logs = @search.paginate(:page => params[:page]).order("created_at DESC").all
  end

  def show
    @ip = params[:ip]
    @mac = PingLog.find_by_ip(@ip).try(:mac)
    @logs = @search.where(:ip => @ip).all
  end

  def clear
    clause = case params[:per]
      when "all"
        :all
      when "year"
        Time.now.beginning_of_year
      when "month"
        Time.now.beginning_of_month
      when "week"
        Time.now.beginning_of_week
      when "day"
        Time.now.beginning_of_day
      else
        nil
    end
    redirect_to(:local_pings) and return unless clause
    if clause.eql? :all
      clear_logs { PingLog.local.destroy_all }
      Ping.clear_redis
    else
      clear_logs { PingLog.local.by_range(clause).destroy_all }
    end
  end

  private

  def clear_logs
    yield
    redirect_to :local_pings
  end

  def meta_search_params
    @search = PingLog.local.search(params[:search] || {"up_between" => Time.now})
  end
end
__END__
.where("created_at < ?", clause)