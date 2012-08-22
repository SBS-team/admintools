class DevicesController < ApplicationController
  before_filter :users_all, :only => [:index, :new, :edit, :create, :update]
  before_filter :current_device, :only => [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @search = Device.search(params[:search])
    @devices = @search.order(sort_column+ " " + sort_direction).all
  end

  def new
    @device = Device.new
  end

  def show

  end

  def edit

  end

  def create
    @device = Device.new(params[:device])
    if @device.save
      redirect_to :devices
    else
      render :action => "new"
    end
  end

  def update
    if @device.update_attributes(params[:device])
      redirect_to :devices
    else
      render :action => 'edit'
    end
  end

  def destroy
    @device.destroy and redirect_to :devices
  end

  private

  def users_all
    @users ||= User.all
  end

  def current_device
    @device = Device.find_by_id(params[:id])
  end

  def sort_column
    Device.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

end
