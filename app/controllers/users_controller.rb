#encoding=UTF-8
class UsersController < ApplicationController

  before_filter :current_user, :only => [:show, :edit, :update, :destroy]

  def index
    @search = User.search(params[:search] || {"meta_sort" => "id.asc"})
    @users = @search.paginate(:page => params[:page]).order('created_at').all
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
      redirect_to :users, notice: "Пользователь добавлен"
    else
      render :action => 'new'
    end
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to :users, notice: "Пользователь обновлен"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy and redirect_to :users, notice: "Пользователь удален"
  end

  private

  def current_user
    @user = User.find_by_id(params[:id])
  end

end