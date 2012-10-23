class ReportMailer < ActionMailer::Base
  default from: "dmitriy.savran@faceit.com.ua"

  def send_report_mail(teamleader_report, temleader_users_reports)
    @teamleader=@teamleader_report.user
    @teamleader_report=teamleader_report
    @teamleader_users_reports=temleader_users_reports
    addresses=User.where(:role=>'director').select(:email)
    mail(:to => addresses.map(&:email), :subject => "Monthly report from #{@teamleader.full_name} (#{@teamleader.department.name})", :template_path => 'teamleader/report_mailer',:template_name => 'send_report_mail')
  end
end
