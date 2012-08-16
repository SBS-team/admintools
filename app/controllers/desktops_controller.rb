class DesktopsController < ApplicationController
  before_filter :init_vars, :only => [:new, :edit]
  after_filter :init_ids, :only => [:new, :edit]

  def index
    @desktops = Desktop.order('created_at').all
  end

  def new
    @desktop = Desktop.new
  end

  def show
    @desktop = Desktop.find_by_id(params[:id])
  end

  def create
    user = User.find_by_id(params[:user_id])
    room = Room.find_by_id(params[:room_id])

    @desktop = Desktop.new(params[:desktop])

    @desktop.user_id = user.id if user
    @desktop.room_id = room.id if room
      
    @desktop.save ? (redirect_to :desktops) : (init_vars; init_ids; render :action => "new") 
  end

  def edit
    @desktop = Desktop.find_by_id(params[:id])
  end

  def update
    user = User.find_by_id(params[:user_id])
    room = Room.find_by_id(params[:room_id])
    
    @desktop = Desktop.find_by_id(params[:id])
    
    @desktop.attributes = params[:desktop]
        
    @desktop.user_id = user ? user.id : nil
    @desktop.room_id = room ? room.id : nil
        
    @desktop.save ? (redirect_to :desktops) : (init_vars; init_ids; render :action => 'edit')
  end

  def destroy
    @desktop = Desktop.find_by_id(params[:id])
    @desktop.destroy and redirect_to :desktops
  end

private

  def init_vars
    @user = User.all
    @room = Room.all
  end

  def init_ids
    @user_id = (@desktop.id?) ? (@desktop.user.nil?) ? false : (@desktop.user.id) : (false)
    @room_id = (@desktop.id?) ? (@desktop.room.nil?) ? false : (@desktop.room.id) : (false)
  end

end