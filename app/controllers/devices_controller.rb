class DevicesController < ApplicationController
  before_filter :init_vars, :only => [:new, :edit]
  after_filter :init_ids, :only => [:new, :edit]

  def index
    @devices = Device.all
  end

  def new
    @device = Device.new
  end

  def show
    @device = Device.find_by_id(params[:id])
  end

  def create
    user = User.find_by_id(params[:user_id])
    @device = Device.new(params[:device])
    @device.user_id = user.id if user
    @device.save ? (redirect_to :devices) : (init_vars; init_ids; render :action => "new")
  end

  def edit
    @device = Device.find_by_id(params[:id])
  end

  def update
    @device = Device.find_by_id(params[:id])
    @device.update_attributes(params[:device]) ? (redirect_to :devices) : (init_vars; init_ids; render :action => 'edit')
  end

  def destroy
    @device = Device.find_by_id(params[:id])
    @device.destroy and redirect_to :devices
  end

  private

  def init_vars
    @users = User.all
  end
  def init_ids
    @user_id = (@device.id?) ? (@device.user.nil?) ? false : (@device.user.id) : (false)
  end
end
