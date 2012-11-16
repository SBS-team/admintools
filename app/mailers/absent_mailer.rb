class AbsentMailer < ActionMailer::Base
  default from: "LTD FaceIT <emailfaceit@gmail.com>"

  def send_absent_mail(absent)
    @absent=absent
    @user=absent.user
    addresses = User.user_teamleader(@user).select(:email)
    mail(:to => addresses.map(&:email)+["manager@faceit.com.ua"], :subject => t(:'teamleader.absent_mailer.send_absent_mail.subject'), :template_path => 'teamleader/absent_mailer',:template_name => 'send_absent_mail')
  end
end

