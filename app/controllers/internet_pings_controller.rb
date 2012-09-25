#encoding=UTF-8
class InternetPingsController < ApplicationController
before_filter :define_date_range, :only => [:clear, :import]

  def index
    @search = PingLog.where(:ping_type => "Domain").search(params[:search] || {"meta_sort" => 'status.desc'})
    @internet_pings = @search.paginate(:page => params[:page]).all
    @domains ||= Domain.all
  end

  def clear
    unless @from || @to
      msg = "Выберите дату для очищения логов"
    else
      msg = "Логи будут очишены в ближайщее время"
    end
    Resque.enqueue(ClearLogs, :server, @from, @to)
    redirect_to(:internet_pings, notice: "#{msg}")
  end

  def import
    redirect_to(:internet_pings) and return unless @from || @to
    logs = PingLog.includes(:ping).server
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
      csv << ["url", "status", "up", "down"] # header
      block.call.each do |e|
        csv << [e.ping.url, e.status, e.up, e.down]
      end
    end
    send_data import, :type => "text/plain", :filename => "#{Time.now.to_s(:number)}_server_pings_log.csv", :disposition => 'attachment'
  end

  def define_date_range
    @from = params[:from].present? ? (params[:from].to_datetime.midnight) : nil
    @to   = params[:to].present?   ? (params[:to].to_datetime.end_of_day)   : nil
  end
end
