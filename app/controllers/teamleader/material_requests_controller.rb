class Teamleader::MaterialRequestsController < Teamleader::AppTeamleaderController
  before_filter :preinit, :only => [:edit, :update, :destroy, :approve]

  def index
    @material_requests =
        (current_user.is_admin? ? MaterialRequest.unprocessed :
          (current_user.is_user? ? current_user.material_requests :
            MaterialRequest.by_department(current_user.department)).unconfirmed
        ).order("priority DESC")
  end

  def new
    @material_request =  current_user.material_requests.new
    render :layout => false
  end

  def create
    @material_request = current_user.material_requests.new(params[:material_request])
    if @material_request.save
      redirect_to teamleader_material_requests_path
    else
      render :new
    end
  end

  def edit
    render :new, :layout => false
  end

  def update
    if @material_request.update_attributes(params[:material_request])
      redirect_to teamleader_material_requests_path
    else
      render :new
    end
  end

  def destroy
    @material_request.destroy
    redirect_to teamleader_material_requests_path
  end

  def send_requests
    @material_requests = MaterialRequest.by_department(current_user.department).unconfirmed
    MaterialRequestMailer.send_material_request(@material_requests).deliver
    @material_requests.update_all(:status => false)
    redirect_to teamleader_material_requests_path
  end

  def approve
    MaterialRequestMailer.material_request_response(@material_request).deliver
    @material_request.destroy
    redirect_to teamleader_material_requests_path
  end

private
  def preinit
    redirect_to teamleader_material_requests_path unless (@material_request = (current_user.is_user? ? current_user.material_requests : MaterialRequest.by_department(current_user.department)).find_by_id([params[:id], params[:material_request_id]]))
  end
end