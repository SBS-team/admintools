class DesktopsController < ApplicationController
  before_filter :all_users_and_rooms, :only => [:new, :edit, :create, :update]
  before_filter :current_desktop, :only => [:edit, :destroy, :update, :show]

  def index
    @desktops = Desktop.order('created_at').all
  end

  def new
    @desktop = Desktop.new
  end

  def show

  end

  def edit

  end

  def create
    @desktop = Desktop.new(params[:desktop])
    if @desktop.save
      redirect_to :desktops
    else
      render :action => "new"
    end
  end

  def update
    if @desktop.update_attributes(params[:desktop])
      redirect_to :desktops
    else
      render :action => 'edit'
    end
  end

  def destroy
    @desktop.destroy and redirect_to :desktops
  end

private

  def all_users_and_rooms
    @user ||= User.all
    @room ||= Room.all
  end

  def current_desktop
    @desktop = Desktop.find_by_id(params[:id])
  end

end