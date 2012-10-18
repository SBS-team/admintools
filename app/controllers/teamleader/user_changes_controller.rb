class Teamleader::UserChangesController < Teamleader::AppTeamleaderController
 def show
   @user_changes=UserChange.find_by_id(params[:id])
   @user = @user_changes.edited
 end
end
