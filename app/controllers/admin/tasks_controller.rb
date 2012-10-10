class Admin::TasksController < Admin::AppAdminController
  before_filter :load_tasks, :except => [:index]
  before_filter :check_scheduler, :except => [:start_workers, :stop_workers]
  before_filter :check_workers, :except => [:start_scheduler, :stop_scheduler]

  def index
  end

  def start_workers
    Rake::Task['resque:start_workers'].invoke unless @workers
    # %x{ rake resque:start_workers } unless @workers
    render :json => {:status => 1}
  end

  def stop_workers
    Rake::Task['resque:stop_workers'].invoke if @workers
    # %x{ rake resque:stop_workers } if @workers
    render :json => {:status => 1}
  end

  def start_scheduler
    Rake::Task['resque:start_scheduler'].invoke unless @scheduler
    # %x{ rake resque:start_scheduler } unless @scheduler
    render :json => {:status => 1}
  end

  def stop_scheduler
    Rake::Task['resque:stop_scheduler'].invoke if @scheduler
    # %x{ rake resque:stop_scheduler } if @scheduler
    render :json => {:status => 1}
  end

  private

  def check_scheduler
    @pid = Rails.root + "tmp/pids/resque_scheduler.pid"
    if File.exists? @pid
      pid = File.read(@pid).to_i
      scheduler = %x"ps #{pid} | grep resque-scheduler"
      FileUtils.rm_f(@pid) unless scheduler.present?
    else
      scheduler = nil
    end
    @scheduler = scheduler.present? ? true : nil
  end

  def check_workers
    @workers = (Resque.workers.count > 0) ? true : nil
  end

  def load_tasks
    require 'rake'
    Rake::Task.clear
    Admintools::Application.load_tasks
  end
end