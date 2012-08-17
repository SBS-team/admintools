class UsersController < ApplicationController
  before_filter :current_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.order('created_at').all
  end

  def new
    @user = User.new
  end

  def show

  end

  def edit

  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to :users, notice: 'User added'
    else
      render :action => 'new'
    end
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to :users, notice: 'User updated'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy and redirect_to :users
  end

  def current_user
    @user = User.find_by_id(params[:id])
  end
end