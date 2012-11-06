class Admin::LocalPings::SubnetworksController < Admin::AppAdminController

  def new
    @network = Subnetwork.new
  end

  def create
    @network = Subnetwork.new(params[:subnetwork])
    if @network.save
      redirect_to :admin_local_pings, notice: t(:'admin.local_pings.subnetworks.create.created')
    else
      render :new
    end
  end

  def destroy
    @network = Subnetwork.find(params[:id])
    if @network.destroy
      redirect_to :admin_local_pings, notice: t(:'admin.local_pings.subnetworks.destroy.destroyed')
    else
      redirect_to :admin_local_pings
    end
  end
end