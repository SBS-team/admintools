class RoomsController < ApplicationController
  before_filter :user_all, :only => [:new, :edit, :create, :update]

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def show

  end

  def edit
    @room = Room.find(params[:id])
  end

  def destroy
    Room.find(params[:id]).destroy
    redirect_to :root
  end

  def create
    @room = Room.new(params[:room])
    if @room.save
      redirect_to :root
    else
      render :action => "new"
    end
  end

  def update
    @room = Room.find(params[:id])
    if @room.update_attributes(params[:room])
      redirect_to :root
    else
      render :action => "edit"
    end
  end

  private

  def user_all
    @users = User.all
  end
end
