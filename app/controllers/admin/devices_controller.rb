class Admin::DevicesController < Admin::AppAdminController
  before_filter :users_all, :only => [:index, :new, :edit, :create, :update]
  before_filter :current_device, :only => [:show, :edit, :update, :destroy]

  def index
    @search = Device.search(params[:search] || {"meta_sort" => "id.asc"})
    @devices = @search.includes(:user).paginate(:page => params[:page]).order('created_at').all
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
      redirect_to :admin_devices, :notice => t(:'admin.devices.create.created')
    else
      render :action => "new"
    end
  end

  def update
    if @device.update_attributes(params[:device])
      redirect_to :admin_devices, :notice => t(:'admin.devices.update.updated', :name => @device.name)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @device.destroy and redirect_to :admin_devices, :notice => t(:'admin.devices.destroy.destroyed', :name => @device.name)
  end

  private

  def users_all
    @users ||= User.all
  end

  def current_device
    @device = Device.find_by_id(params[:id])
  end
end