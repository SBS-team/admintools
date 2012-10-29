class Admin::DesktopsController < Admin::AppAdminController
  before_filter :all_users_and_rooms, :only => [:index, :new, :edit, :create, :update]
  before_filter :current_desktop, :only => [:show, :edit, :update, :destroy]

  def index
    @search = Desktop.search(params[:search] || {"meta_sort" => "id.asc"})
    @desktops = @search.includes(:user, :room).paginate(:page => params[:page]).order('created_at').all
  end

  def new
    @desktop = Desktop.new
  end

  def show
  end

  def edit
  end

  def create
    @desktop = Desktop.new(params[:desktop])
    if @desktop.save
      redirect_to :admin_desktops, :notice => t(:'admin.desktops.create.created', :name => @desktop.name)
    else
      render :action => "new"
    end
  end

  def update
    if @desktop.update_attributes(params[:desktop])
      redirect_to :admin_desktops, :notice => t(:'admin.desktops.update.updated', :name => @desktop.name)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @desktop.destroy and redirect_to :admin_desktops, :notice => t(:'admin.desktops.destroy.destroyed', :name => @desktop.name)
  end

  private
  def all_users_and_rooms
    @users ||= User.all
    @rooms ||= Room.all
  end

  def current_desktop
    @desktop = Desktop.find_by_id(params[:id])
  end
end