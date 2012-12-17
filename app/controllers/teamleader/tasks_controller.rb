class Teamleader::TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params[:task])
    @task.creator_id << current_user
    if @task.save
     redirect_to @task, notice: 'Task was successfully created.'
    else
      render action: "new"
    end
  end
end
