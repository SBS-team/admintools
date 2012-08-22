class UsersController < ApplicationController
  before_filter :current_user, :only => [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @search = User.search(params[:search])
    @users = @search.order(sort_column+ " " + sort_direction).all
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

  private

  def current_user
    @user = User.find_by_id(params[:id])
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

end