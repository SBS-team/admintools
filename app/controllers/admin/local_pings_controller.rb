class Admin::LocalPingsController < Admin::AppAdminController
  before_filter :meta_search_params, :only => [:index, :show]
  before_filter :define_date_range, :only => [:clear, :import]

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
    unless @from || @to
      flash[:alert] = t :'admin.clear_logs.choose'
    else
      flash[:notice] = t :'admin.clear_logs.cleaning'
      Resque.enqueue(ClearLogs, :local, @from, @to)
    end
    redirect_to(:admin_local_pings)
  end

  def import
    redirect_to(:admin_local_pings) and return unless @from || @to
    logs = PingLog.includes(:ping).local
    if (@from && @to)
      entries = logs.where(:created_at => @from..@to).all
    elsif (@from && @to.nil?)
      entries = logs.from_date(@from).all
    elsif (@from.nil? && @to)
      entries = logs.to_date(@to).all
    end
    import_logs{ entries } if entries
  end

  private

  def import_logs( &block )
    import = CSV.generate do |csv|
      csv << ["ip", "mac", "user_name", "up", "down", "date"] # header
      block.call.each do |e|
        user = e.ping_id ? (e.ping.user.try(:full_name) || '-'*10) : '?'*3
        csv << [e.ip, e.mac, user, e.up, e.down, e.created_at]
      end
    end
    send_data import, :type => "text/plain", :filename => "#{Time.now.to_s(:number)}_local_pings_log.csv", :disposition => 'attachment'
  end

  def meta_search_params
    @search = PingLog.local.search(params[:search] || {"up_between" => Time.now})
  end

  def define_date_range
    @from = params[:from].present? ? (params[:from].to_datetime.midnight) : nil
    @to   = params[:to].present?   ? (params[:to].to_datetime.end_of_day)   : nil
  end
end