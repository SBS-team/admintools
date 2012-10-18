#encoding=UTF-8
class Admin::UsersController < Admin::AppAdminController

  before_filter :current_user, :only => [:show, :edit, :create, :update, :destroy]
  respond_to :js, :html

  def index
    @deleted = params[:deleted]
    if @deleted=="1"
      @search = User.only_deleted.search(params[:search] || {"meta_sort" => "id.asc"})
    else
      @search = User.search(params[:search] || {"meta_sort" => "id.asc"})
    end
    @users = @search.includes(:desktop, :room).paginate(:page => params[:page]).order('created_at').all
    respond_to do |format|
      format.html
      format.js {render :layout => false}
    end
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
    @user.password = @user.password_confirmation = @user.email.split('@')[0]
    if @user.save
      redirect_to :admin_users, notice: "Пользователь добавлен #{@user.full_name}"
    else
      render :action => 'new'
    end
  end

  def update
    params[:user].update(:changer => current_admin)
    if @user.update_attributes(params[:user])
      redirect_to :admin_users, notice: "Информация изменена"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy and redirect_to :admin_users, notice: "Пользователь удален"
  end

  def restore
    User.only_deleted.find_by_id(params[:id]).update_attributes(:deleted_at => nil)
    respond_to do |format|
      format.html
      format.js {redirect_to admin_users_path(:deleted => 1), notice: "Пользователь восстановлен"}
    end
  end

  private

  def current_user
    @user = User.find_by_id(params[:id])
  end
end