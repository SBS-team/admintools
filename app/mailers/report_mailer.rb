class ReportMailer < ActionMailer::Base
  default from: "dmitriy.savran@faceit.com.ua"

  def send_report_mail(teamleader_report, temleader_users_reports)
    @teamleader_report=teamleader_report
    @teamleader_users_reports=temleader_users_reports
    @teamleader=@teamleader_report.user
    #addresses=["max.vodyanickij@faceit.com.ua","nick.zadvorniy@faceit.com.ua",@teamleader.email]
    mail(:to => @teamleader_report.report_emails, :subject => "Monthly report from #{@teamleader.full_name} (#{@teamleader.department.name})", :template_path => 'teamleader/report_mailer',:template_name => 'send_report_mail')
  end
end
