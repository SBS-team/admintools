#encoding=UTF-8
class Admin::UsersController < Admin::AppAdminController

  before_filter :current_user, :only => [:show, :edit, :create, :update, :destroy]

  def index
    @search = User.search(params[:search] || {"meta_sort" => "id.asc"})
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
    @user.password = @user.password_confirmation = @user.email.split('@')[0]
    if @user.save
      redirect_to :admin_users, notice: "Пользователь добавлен #{@user.full_name}"
    else
      render :action => 'new'
    end
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to :admin_users#, notice: "Пользователь обновлен"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy and redirect_to :admin_users#, notice: "Пользователь удален"
  end

  private

  def current_user
    @user = User.find_by_id(params[:id])
  end
end