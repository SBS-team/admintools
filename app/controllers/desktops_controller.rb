class DesktopsController < ApplicationController
  before_filter :all_users_and_rooms, :only => [:index, :new, :edit, :create, :update]
  before_filter :current_desktop, :only => [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @search = Desktop.search(params[:search])
    @desktops = @search.order(sort_column+ " " + sort_direction).all
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
    @users ||= User.all
    @rooms ||= Room.all
  end

  def current_desktop
    @desktop = Desktop.find_by_id(params[:id])
  end

  def sort_column
    Desktop.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

end