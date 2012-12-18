class Teamleader::UserChangesController < Teamleader::AppTeamleaderController
  load_and_authorize_resource :only => [:index]

  def index
    if current_user.is_manager? || current_user.is_admin?
      @users_changes = UserChange.includes([:editor, :edited]).order('user_changes.created_at DESC').paginate(:page => params[:page])
    elsif current_user.is_teamleader?
      @users_changes = UserChange.subordinates(current_user).order('user_changes.created_at DESC').paginate(:page => params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
    @user_changes = @user.user_changes.paginate(:page => params[:page])
    authorize! :read, @user
  end
end