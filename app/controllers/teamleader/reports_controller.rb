# encoding: UTF-8
class Teamleader::ReportsController < Teamleader::AppTeamleaderController
  before_filter :set_user
  before_filter :find_report, :only => [:show, :edit, :update, :destroy]

  def index
    @report_check = current_user.reports.find_by_report_send(false)
    @report_sended = current_user.reports.order("created_at DESC").find_all_by_report_send(true)
    @teamleader_users_reports_sended = current_user.reports.includes(:users_reports).where(:report_send=>true).order("created_at DESC")
    @reports_sended = Report.includes(:users_reports).where(:report_send=>true).order("created_at DESC")
  end

  def show
  end

  def new
    @report_check=current_user.reports.find_by_report_send(false)
    unless @report_check
      @report = Report.new
    else
      redirect_to teamleader_reports_path, :notice => "Вы не можете создать новый отчёт пока ваш тимлид не отправил предыдущий"
    end
  end

  def edit
  end

  def create
    @report = current_user.reports.build(params[:report])
    if @report.save
      if current_user.role=="teamleader"
        @teamleader_users_reports_unsended.update_all(:teamleader_report_id => @report.id)
      end
      redirect_to teamleader_reports_path, :notice => "Отчёт сохранён"
    else
      render :action => "new"
    end
  end

  def update
    if @report.update_attributes(params[:report])
      if current_user.role=="teamleader"
        @teamleader_users_reports_unsended.update_all(:teamleader_report_id => @report.id)
      end
      redirect_to teamleader_reports_path, :notice => "Отчёт отредактирован"
    else
      render :action => 'edit'
    end
  end

  def teamleader_mail_send
    if @report_unsended.update_attributes(:report_send => true)
      if current_user.role=="teamleader"
        ReportMailer.send_report_mail(@report_unsended, @teamleader_users_reports_unsended).deliver # Отправка отчётов на емейл, когда будут роли для директора.
        @teamleader_users_reports_unsended.update_all(:report_send => true, :teamleader_report_id => @report_unsended.id)
      end
      redirect_to teamleader_reports_path, :notice => "Отчёт отправлен"
    else
      redirect_to teamleader_reports_path, :notice => "Не удалось отправить отчёт"
    end
  end

  def destroy
    @report.destroy and redirect_to teamleader_reports_path, :notice => "Отчёт за #{@report.updated_at.strftime("%d %b %Y")} удален"
  end
  private

  def set_user
    @user = current_user
    @user_teamleader = User.user_teamleader(current_user).first
    @teamleader_users = User.teamleader_users(current_user) << current_user
    @teamleader_users_reports_unsended = Report.users_unsended_reports
    @teamleader_users_reports_unsended = User.subordinates(@teamleader_users_reports_unsended,current_user)
    @report_unsended = current_user.reports.find_by_report_send(false)
  end

  def find_report
    @report = Report.find(params[:id])
    authorize! Report,@report
  end
end
