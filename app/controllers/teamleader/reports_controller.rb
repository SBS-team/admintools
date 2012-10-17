# encoding: UTF-8
class Teamleader::ReportsController < Teamleader::AppTeamleaderController
  before_filter :set_user
  before_filter :find_report, :only => [:show, :edit, :update, :destroy]

  def index
    @reports=current_user.reports
    @user_teamleader= User.user_teamleader(@user).first
  end

  def show
  end

  def new
    @report = Report.new
  end

  def edit
  end

  def create
    @report = current_user.reports.build(params[:report])
    if @report.save
      redirect_to teamleader_reports_path, :notice => "Отчёт сохранён."
    else
      render :action => "new"
    end
  end

  def update
    if @report.update_attributes(params[:report])
      redirect_to teamleader_reports_path, :notice => "Отчёт отредактирован."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @report.destroy and redirect_to teamleader_reports_path, :notice => "Отчёт за #{@report.updated_at.strftime("%d %b %Y")} удален."
  end
  private

  def set_user
    @user = current_user
  end

  def find_report
    @report=Report.find(params[:id])
  end

end
