class AbsentMailer < ActionMailer::Base
  default from: "LTD FaceIT <emailfaceit@gmail.com>"

  def send_absent_mail(absent)
    @absent=absent
    @user=absent.user
    addresses = User.where(:role => ["manager", "admin"]).pluck(:email) << User.user_teamleader(@user).first.email
    mail(:to => addresses, :subject => t(:'teamleader.absent_mailer.send_absent_mail.subject'), :template_path => 'teamleader/absent_mailer',:template_name => 'send_absent_mail')
  end
end

