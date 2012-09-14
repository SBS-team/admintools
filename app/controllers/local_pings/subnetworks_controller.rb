#encoding=UTF-8
class LocalPings::SubnetworksController < ApplicationController

  def new
    @network = Subnetwork.new
  end

  def create
    @network = Subnetwork.new(params[:subnetwork])
    if @network.save
      redirect_to :local_pings, notice: "Подсеть добавлена"
    else
      redirect_to :local_pings, alert: "Неверный формат подсети"
    end
  end

  def destroy
    @network = Subnetwork.find(params[:id])
    if @network.destroy
      redirect_to :local_pings, notice: "Подсеть удалена"
    else
      redirect_to :local_pings
    end
  end

end