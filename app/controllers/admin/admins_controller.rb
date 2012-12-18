class Admin::AdminsController < Admin::AppAdminController

  before_filter :find_admin, :only => [:show, :edit, :update, :destroy]
  before_filter :check_admin, :only => [:new, :create, :edit, :update, :destroy]

  def index
    @deleted = params[:deleted]
    if @deleted=="1"
      @search = Admin.only_deleted.search(params[:search] || {"meta_sort" => "id.asc"})
    else
      @search = Admin.search(params[:search] || {"meta_sort" => "id.asc"})
    end
    @admins = @search.paginate(:page => params[:page]).order('created_at').all


    #def index
    #  @deleted = params[:deleted]
    #  if @deleted=="1"
    #    @search = User.only_deleted.search(params[:search] || {"meta_sort" => "id.asc"})
    #  else
    #    @search = User.search(params[:search] || {"meta_sort" => "id.asc"})
    #  end
    #  @users = @search.includes(:desktop, :room).paginate(:page => params[:page]).order('created_at').all
    #end

    #


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
      redirect_to :admin_admins, notice: t(:'admin.admins.create.created', name: @admin.name)
    else
      render :action => 'new'
    end
  end

  def update
    if @admin.update_attributes(params[:admin])
      redirect_to :admin_admins, notice: t(:'admin.admins.update.updated')
    else
      render :action => 'edit'
    end
  end

  def destroy
    @admin.destroy and redirect_to :admin_admins, notice: t('admin.admins.destroy.destroyed', :name => @admin.name)
  end

  def restore
    admin = Admin.only_deleted.find_by_id(params[:id])
    admin.update_attributes(:deleted_at => nil)
    redirect_to admin_admins_path(:deleted => 1), :notice => t('admin.admins.restore.restored', :name => admin.name)
  end

  private

  def find_admin
    @admin = Admin.find_by_id(params[:id])
  end

  def check_admin
    redirect_to :admin_admins unless current_admin.is_super_admin?
  end
end