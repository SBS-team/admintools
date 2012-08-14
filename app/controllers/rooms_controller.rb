class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
    @users = User.all
  end

  def show

  end

  def create
    @room = Room.new(params[:room])
    if @room.save
      redirect_to :root
    else
      @users = User.all
      render(:action => "new")
    end
  end
end
