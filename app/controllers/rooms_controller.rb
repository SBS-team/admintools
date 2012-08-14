class RoomsController < ApplicationController

  def index
    @rooms = Room.all
    @users = User.all
  end

  def new
    @room = Room.new
  end

  def show

  end

  def create
    @room = Room.new(params[:room])
    if @room.save
      redirect_to :root
    else
      render(:action => "new")
    end
  end
end
