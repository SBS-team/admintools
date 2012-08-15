class DesktopsController < ApplicationController
  before_filter :init_vars, :only => [:new]

  def index
    @desktops = Desktop.all
  end

  def new
    @desktop = Desktop.new
  end

  def create
    user = params[:user_id]
    room = params[:room_id]

    @desktop = Desktop.new(params[:desktop])

    if(User.find_by_id(user) && Room.find_by_id(room))
      @desktop.user_id = user
      @desktop.room_id = room
      if @desktop.save
        redirect_to :desktops
      else
        init_vars
        render :action => "new"
      end
    else
      init_vars
      render :action => "new"
    end

  end

  def edit
    @desktop = Desktop.find_by_id(params[:id])
  end

  def update
    @desktop = Desktop.find_by_id(params[:id])
    @desktop.update_attributes(params[:desktop]) ? (redirect_to :desktops, notice: 'User updated') : (render :action => 'edit')
  end

private
  def init_vars
    @room = Room.all
    @user = User.all
  end
end
