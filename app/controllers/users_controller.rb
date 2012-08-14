class UsersController < ApplicationController
  def index
    @users = User.order('created_at').all
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.save ? (redirect_to :users, notice: 'User added') : (render :action => 'new')
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.update_attributes(params[:user]) ? (redirect_to :users, notice: 'User updated') : (render :action => 'edit')
  end
end