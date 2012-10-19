class Teamleader::UserChangesController < Teamleader::AppTeamleaderController
  load_and_authorize_resource

  def index
    if current_user.is_manager? || current_user.is_admin?
      @user_changes = UserChange.includes([:editor,:edited]).order('user_changes.created_at DESC').paginate(:page => params[:page])
    elsif current_user.is_teamleader?
      @user_changes = UserChange.subordinates(current_user).order('user_changes.created_at DESC').paginate(:page => params[:page])
    end
  end
end