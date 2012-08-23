class AdminsController < ApplicationController

  before_filter :current_admin, :only => [:show, :edit, :update, :destroy]

  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def show

  end

  def edit

  end

  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      redirect_to :admins, notice: 'Admin added'
    else
      render :action => 'new'
    end
  end

  def update
    if @admin.update_attributes(params[:admin])
      redirect_to :admins, notice: 'Admin updated'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @admin.destroy and redirect_to :admins
  end

  private

  def current_admin
    @admin = Admin.find_by_id(params[:id])
  end

end
