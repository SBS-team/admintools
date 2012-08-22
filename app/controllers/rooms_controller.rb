#encoding=UTF-8
class RoomsController < ApplicationController
  before_filter :user_all, :only => [:index, :new, :edit, :create, :update]
  before_filter :current_room, :only => [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @search = Room.search(params[:search])
    @rooms = @search.order(sort_column+ " " + sort_direction).all
  end

  def new
    @room = Room.new
  end

  def show

  end

  def edit

  end

  def create
    @room = Room.new(params[:room])
    if @room.save
      redirect_to :root
    else
      render :action => "new"
    end
  end

  def update
    if @room.update_attributes(params[:room])
      redirect_to :root
    else
      render :action => "edit"
    end
  end

  def destroy
    @room.destroy and redirect_to :root
  end

  private

  def user_all
    @users ||= User.all
  end

  def current_room
    @room = Room.find(params[:id])
  end

  def sort_column
    Room.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

end
