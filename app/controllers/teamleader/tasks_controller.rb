class Teamleader::TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params[:task].update(:creator_id => current_user.id ))
    if @task.save
     redirect_to teamleader_tasks_path, notice: 'Task was successfully created.'
    else
      render action: "new"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to teamleader_tasks_path, notice: 'Task was successfully deleted.'
  end

end
