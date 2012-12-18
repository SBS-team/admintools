#encoding:utf-8
class Teamleader::DepartmentsController < ApplicationController
  load_and_authorize_resource :except => :restore
  before_filter :init_department, :only => [:show, :edit, :update, :destroy]
  def index
    @deleted = params[:deleted]
    if @deleted=="1"
      @departments = Department.only_deleted
    else
      @departments = Department.all
    end
  end

  def show
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(params[:department])
    if @department.save
      redirect_to :teamleader_departments, notice: t(:'teamleader.departments.create.created', name: @department.name)
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @department.update_attributes(params[:department])
      redirect_to :teamleader_departments, notice: t(:'teamleader.departments.update.updated')
    else
      render :action => 'edit'
    end
  end

  def destroy
    @department.destroy and redirect_to :teamleader_departments, notice: t(:'teamleader.departments.destroy.destroyed', name: @department.name)
  end

  def restore
    authorize! :restore, :departments
    department = Department.only_deleted.find_by_id(params[:id])
    department.recover
    redirect_to teamleader_departments_path(:deleted => 1), :notice => t('teamleader.departments.restore.restored', :name => department.name)
  end

  private

  def init_department
    @department = Department.find(params[:id])
  end
end