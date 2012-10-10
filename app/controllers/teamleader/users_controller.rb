class Teamleader::UsersController < Teamleader::AppTeamleaderController
  before_filter :init_user, :only => [:show, :update, :destroy]

  def index
    @user = current_user
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to :teamleader_users
    else
      render :action => 'edit'
    end
  end

  private

  def init_user
    @user = User.find_by_id(params[:id])
  end
end