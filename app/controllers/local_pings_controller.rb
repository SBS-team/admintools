#encoding=UTF-8
class LocalPingsController < ApplicationController
  before_filter :meta_search_params, :only => [:index, :show]
  before_filter :define_range, :only => [:clear, :import]

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
      msg = "Выберите дату для очищений логов"
    else
      msg = "Логи будут очишены в ближайщее время"
    end
    Resque.enqueue(ClearLogs, @from, @to)
    redirect_to(:local_pings, notice: "#{msg}")
  end

  def import
    redirect_to(:local_pings) and return unless @from || @to
    logs = PingLog.local
    if (@from && @to)
      import_logs(logs.where(:created_at => @from..@to).all)
    elsif (@from && @to.nil?)
      import_logs(logs.from_date(@from).all)
    elsif (from.nil? && to)
      import_logs(logs.to_date(@to).all)
    end
  end

  private

  def import_logs(entries)
    import = CSV.generate do |csv|
      csv << ["ip", "mac", "user_name", "up", "down", "date"] # header
      entries.each do |e|
        user = e.ping.user.try(:full_name) if e.ping_id
        csv << [e.ip, e.mac, user || :empty, e.up, e.down, e.created_at]
      end
    end
    send_data import, :type => "text/plain", :filename => "#{Time.now.to_s(:number)}_local_pings_log.csv", :disposition => 'attachment'
  end

  def meta_search_params
    @search = PingLog.local.search(params[:search] || {"up_between" => Time.now})
  end

  def define_range
    @from = params[:from].present? ? (params[:from].to_datetime.utc) : nil
    @to   = params[:to].present?   ? (params[:to].to_datetime.utc)   : nil
  end

end