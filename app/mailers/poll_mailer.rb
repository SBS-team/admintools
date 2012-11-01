class PollMailer < ActionMailer::Base
  default from: "emailfaceit@gmail.com"

  def send_poll_mail(poll)
    @poll=poll
    #addresses = User.all
    addresses = []
    addresses << User.find(24)
    addresses << User.find(18)
    mail(:to => addresses.map(&:email), :subject => "New Poll", :template_path => 'teamleader/poll_mailer',:template_name => 'send_poll_mail')
  end
end
