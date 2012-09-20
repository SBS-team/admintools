class ConstructorsController < ApplicationController
  def show
    @room_plan = RoomPlan.find(params[:id])
    @room_id = params[:id]
    @desktops = Room.find(params[:id]).desktops.includes(:user)
  end

  def create
    @workplace = Workplace.new(params[:workplace])
    if @workplace.save
      render :json => {:status => 1, :workplace => @workplace}
    else
      render :json => {:status => -1, :workplace => @workplace}
    end
  end

  def update
    @workplace = Workplace.find(params[:id])

    if params[:workplace][:desktop_id]
      old_workplace = Workplace.find_by_desktop_id(params[:workplace][:desktop_id])
      # old_workplace.update_attributes({:workplace => {:desktop_id => nil}})
    end

    if @workplace.update_attributes(params[:workplace])
      render :json => {:status => 1, :workplace => @workplace}
    else
      render :json => {:status => -1, :workplace => @workplace}
    end
  end

  def destroy
    @workplace = Workplace.find(params[:id])
    if @workplace.destroy
      render :json => {:status => 1, :workplace => @workplace}
    else
      render :json => {:status => -1, :workplace => @workplace}
    end
  end
end