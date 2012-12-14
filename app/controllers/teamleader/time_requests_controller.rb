class Teamleader::TimeRequestsController < Teamleader::AppTeamleaderController
  before_filter ->{@time_requests = current_user.time_requests.order(:request_date)}, :only => [:index]
  before_filter ->{redirect teamleader_time_requests_path unless (@time_request = current_user.time_requests.find_by_id(params[:id]))}, :only => [:edit, :destroy, :update]

  def index
  end

  def new
    @time_request = TimeRequest.new
    render :layout => false
  end

  def create
    if (@time_request = current_user.time_requests.create(params[:time_request])).persisted?
      TimeRequestMailer.deliver_send_time_request(@time_request)
      redirect_to teamleader_user_time_requests_path(current_user)
    else
      render :action => :new
    end
  end

  def edit
    render :action => :new, :layout => false
  end

  def update
    if @time_request.update_attributes(params[:time_request])
      redirect_to teamleader_user_time_requests_path(current_user)
    else
      render :action => :new
    end
  end

  def destroy
    @time_request.destroy and redirect_to teamleader_user_time_requests_path(current_user)
  end
end