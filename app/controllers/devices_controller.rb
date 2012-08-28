#encoding=UTF-8
class DevicesController < ApplicationController
  before_filter :users_all, :only => [:index, :new, :edit, :create, :update]
  before_filter :current_device, :only => [:show, :edit, :update, :destroy]

  def index
    @search = Device.search(params[:search] || {"meta_sort" => "id.asc"})
    @devices = @search.order('created_at').all
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
      redirect_to :devices, :notice => "Личное устройство добавлено"
    else
      render :action => "new"
    end
  end

  def update
    if @device.update_attributes(params[:device])
      redirect_to :devices, :notice => "Личное устройство обновлено"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @device.destroy and redirect_to :devices, :notice => "Личное устройство удалено"
  end

  private

  def users_all
    @users ||= User.all
  end

  def current_device
    @device = Device.find_by_id(params[:id])
  end

end
