class Teamleader::TasksController < ApplicationController

  before_filter :find_the_user, :only => [:edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(params[:task].update(:creator_id => current_user.id ))
    if @task.save
     redirect_to teamleader_tasks_path, notice: 'Task was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @task.update_attributes(params[:task])
      redirect_to teamleader_tasks_path, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @task.destroy
    redirect_to teamleader_tasks_path, notice: 'Task was successfully deleted.'
  end

  private

  def find_the_user
    @task = Task.find(params[:id])
  end

end
