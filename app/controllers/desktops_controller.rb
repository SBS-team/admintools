class DesktopsController < ApplicationController
  before_filter :all_users_and_rooms, :only => [:new, :edit, :create, :update]

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
    @desktop = Desktop.new(params[:desktop])
    @desktop.save ? (redirect_to :desktops) : (render :action => "new")
  end

  def edit
    @desktop = Desktop.find_by_id(params[:id])
  end

  def update
    @desktop = Desktop.find_by_id(params[:id])
    @desktop.update_attributes(params[:desktop]) ? (redirect_to :desktops) : (render :action => 'edit')
  end

  def destroy
    @desktop = Desktop.find_by_id(params[:id])
    @desktop.destroy and redirect_to :desktops
  end

private

  def all_users_and_rooms
    @user ||= User.all
    @room ||= Room.all
  end

end