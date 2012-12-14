class Teamleader::TimeRequestsController < Teamleader::AppTeamleaderController
  before_filter :preinit, :except => [:index, :new, :create]

  def index
    @time_requests = (current_user.is_admin? ? TimeRequest : current_user.time_requests).order(:request_date)
  end

  def new
    @time_request = TimeRequest.new
    render :layout => false
  end

  def create
    if (@time_request = current_user.time_requests.create(params[:time_request])).persisted?
      TimeRequestMailer.send_time_request(@time_request).deliver
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

#### admin section
  def approve
    update_request {@time_request.approved = true}
  end

  def decline
    update_request {@time_request.approved = false}
  end

  def alternative
    render :layout => false
  end

  protected
  def update_request(&block)
    yield
    if params['time_request'].present?
      old_time = @time_request.requested_time
      @time_request.update_attributes(params['time_request'].slice(:requested_time))
      TimeRequestMailer.time_request_response(@time_request, old_time).deliver
    else
      TimeRequestMailer.time_request_response(@time_request).deliver
      @time_request.save
    end
    redirect_to teamleader_time_requests_path
  end

  def preinit
    redirect_to teamleader_time_requests_path unless
        (@time_request = (current_user.is_admin? ? TimeRequest : current_user.time_requests).find_by_id([params[:id], params[:time_request_id]]))
  end
end