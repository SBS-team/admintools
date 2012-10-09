class Admin::AdminsController < Admin::AppAdminController

  before_filter :find_admin, :only => [:show, :edit, :update, :destroy]
  before_filter :check_admin, :only => [:new, :create, :edit, :update, :destroy]

  def index
    @search = Admin.search(params[:search] || {"meta_sort" => "id.asc"})
    @admins = @search.paginate(:page => params[:page]).order('created_at').all
  end

  def new
    @admin = Admin.new
  end

  def show

  end

  def edit

  end

  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      redirect_to :admin_admins, notice: 'Admin added'
    else
      render :action => 'new'
    end
  end

  def update
    if @admin.update_attributes(params[:admin])
      redirect_to :admins, notice: 'Admin updated'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @admin.destroy# and redirect_to :admins
  end

  private

  def find_admin
    @admin = Admin.find_by_id(params[:id])
  end

  def check_admin
    redirect_to :admins unless current_admin.is_super_admin?
  end

end
