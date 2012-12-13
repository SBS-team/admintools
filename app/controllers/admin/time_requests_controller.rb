class Admin::UserTimeRequestsController < Admin::AppAdminController
  before_filter ->{@time_request = TimeRequest.where(params[:id])}, :only => [:update]

  def index
    @time_requests = TimeRequest.all
  end

  def update
    @time_request.update_attributes(params[:time_request])
  end
end