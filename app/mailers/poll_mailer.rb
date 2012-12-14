class PollMailer < ActionMailer::Base
  default from: "LTD FaceIT <emailfaceit@gmail.com>"

  def send_poll_mail(poll,user)
    @poll=poll
    @user=user
    mail(:to => User.all.map(&:email), :subject => t(:'teamleader.mailer.poll_mailer.new_poll'), :template_path => 'teamleader/poll_mailer',:template_name => 'send_poll_mail')
  end
end
