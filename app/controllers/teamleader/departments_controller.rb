#encoding:utf-8
class Teamleader::DepartmentsController < ApplicationController
  before_filter :init_department, :only => [:show, :edit, :update, :destroy]
  def index
    @departments = Department.all
  end

  def show
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(params[:department])
    if @department.save
      redirect_to :teamleader_departments, notice: "Отдел #{@department.name} добавлен"
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @department.update_attributes(params[:department])
      redirect_to :teamleader_departments, notice: "Информация изменена"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @department.destroy and redirect_to :teamleader_departments, notice: "Отдел удален"
  end

  private

  def init_department
    @department = Department.find(params[:id])
  end
end