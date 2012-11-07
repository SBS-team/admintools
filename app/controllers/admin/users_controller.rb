class Admin::UsersController < Admin::AppAdminController

  before_filter :current_user, :only => [:show, :edit, :create, :update, :destroy]
  before_filter :get_managers, :only => [:new, :create, :edit, :update]

  respond_to :js, :html

  def index
    @deleted = params[:deleted]
    if @deleted=="1"
      @search = User.only_deleted.search(params[:search] || {"meta_sort" => "id.asc"})
    else
      @search = User.search(params[:search] || {"meta_sort" => "id.asc"})
    end
    @users = @search.includes(:desktop, :room).paginate(:page => params[:page]).order('created_at').all
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(params[:user])
    @user.password = @user.password_confirmation = :'123456'
    if @user.save
      redirect_to :admin_users, :notice => t('admin.users.create.created', full_name: @user.full_name)
    else
      render :action => 'new'
    end
  end

  def update
    params[:user].update(:changer => current_admin)
    if @user.update_attributes(params[:user])
      redirect_to :admin_users, :notice => t('admin.users.update.updated')
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy and redirect_to :admin_users, :notice => t('admin.users.destroy.destroyed', :full_name => @user.full_name)
  end

  def restore
    user = User.only_deleted.find_by_id(params[:id])
    user.update_attributes(:deleted_at => nil)
    redirect_to admin_users_path(:deleted => 1), :notice => t('admin.users.restore.restored', :full_name => user.full_name)
  end

  private

  def current_user
    @user = User.find_by_id(params[:id])
  end

  def get_managers
    @managers = User.managers
    @departments = Department.all
  end
end