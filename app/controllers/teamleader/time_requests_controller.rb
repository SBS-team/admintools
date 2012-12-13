class Teamleader::TimeRequestsController < Teamleader::AppTeamleaderController
  before_filter ->{@time_requests = current_user.time_requests}, :only => [:index]
  before_filter ->{@time_request = current_user.time_requests.where(params[:id])}, :only => [:edit, :destroy, :update]

  def index
  end

  def new
    @time_request = TimeRequest.new
  end

  def create
    if (@time_request = TimeRequest.create(params[:time_request])).persisted?
      redirect_to teamleader_user_time_requests_path(current_user)
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    @time_requests.update_attributes(params[:time_request])
  end

  def destroy
    @time_requests.destroy_all and redirect_to :admin_users, :notice => t('admin.users.destroy.destroyed', :full_name => @user.full_name)
  end
end