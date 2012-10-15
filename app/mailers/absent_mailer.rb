class AbsentMailer < ActionMailer::Base
  default from: "dmitriy.savran@faceit.com.ua"

  def send_absent_mail(absent,addresses)
    @absent=absent
    @user=absent.user
    mail(:to => addresses, :subject => "About absent", :template_path => 'teamleader/absent_mailer',:template_name => 'send_absent_mail')
  end
end
