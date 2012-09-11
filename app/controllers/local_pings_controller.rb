class LocalPingsController < ApplicationController
  before_filter :init_redis_data, :only => [:show]

  def index
    @logs = PingLog.paginate(:page => params[:page]).order("created_at DESC").all
  end

  def show 
    @ip = params[:ip]
    @desktop = Desktop.find_by_ip(params[:ip]) || Device.find_by_ip(params[:ip])

    if @desktop
      @pings = @desktop.ping_logs
      @assigned_user = @desktop.user.try(:full_name) || 'unrelated'
      @mac = @desktop.mac
      # .where(:up => Time.now.utc.midnight..Time.now.utc.end_of_day)
    else 
      @pings = PingLog.find_all_by_unregister_ip(params[:ip])
      @assigned_user = ''
      @mac = @pings.first.mac
      # .where(:up => Time.now.utc.midnight..Time.now.utc.end_of_day)
    end
  end

  private

  def init_redis_data
    @redis = ( (Redis.current.exists :local_ping) && Redis.current.sismember(:local_ping, params[:ip]) ) ? ( $redis.hget(params[:ip], :up).to_time.strftime("%H:%M:%S, %d %b %Y") ) : ( nil )
  end
end