#encoding=utf-8
class Teamleader::UsersController < Teamleader::AppTeamleaderController
  before_filter :init_user, :only => [:show, :update, :destroy]
  before_filter :password_for_user, :only => [:edit_password, :update_password]

  def index
    @user = current_user
  end

  def show
    authorize! :manage, @user
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
    authorize! :manage, @user
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to :teamleader_users
    else
      render :action => 'edit'
    end
  end

  def birthday
    @users = User.all.sort_by{|d|d.birthday.day}
  end

  def edit_password
  end

  def update_password
    params[:user].select! { |k,v| k.in? %w`current_password password password_confirmation` }
    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to root_path, notice: :'Пароль изменен'
    else
      render 'edit_password'
    end
  end

  private

  def init_user
    @user = User.find_by_id(params[:id])
  end

  def password_for_user
    @user = current_user
  end
end