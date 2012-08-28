#encoding=UTF-8
class DesktopsController < ApplicationController
  before_filter :all_users_and_rooms, :only => [:index, :new, :edit, :create, :update]
  before_filter :current_desktop, :only => [:show, :edit, :update, :destroy]

  def index
    @search = Desktop.search(params[:search] || {"meta_sort" => "id.asc"})
    @desktops = @search.order('created_at').all
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
      redirect_to :desktops, :notice => "Компьютер #{@desktop.name} добавлен"
    else
      render :action => "new"
    end
  end

  def update
    if @desktop.update_attributes(params[:desktop])
      redirect_to :desktops, :notice => "Компьютер #{@desktop.name} обновлен"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @desktop.destroy and redirect_to :desktops, :notice => "Компьютер #{@desktop.name} удален"
  end

private

  def all_users_and_rooms
    @users ||= User.all
    @rooms ||= Room.all
  end

  def current_desktop
    @desktop = Desktop.find_by_id(params[:id])
  end

end