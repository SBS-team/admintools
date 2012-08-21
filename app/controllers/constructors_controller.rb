class ConstructorsController < ApplicationController
  def show
    @room_plan = RoomPlan.find(params[:id])
    @room_id = params[:id]
  end

  def create
    @workplace = Workplace.new(params[:workplace])
    if @workplace.save
      render :json => @workplace
    else
      render :json => {:text => :error}
    end
  end

  def update
    @workplace = Workplace.find(params[:id])
    
    if @workplace.update_attributes(params[:workplace])
      render :json => @workplace
    end
  end

  def destroy
    @workplace = Workplace.find(params[:id])
    if @workplace.destroy    
      render :json => @workplace
    end
  end
end