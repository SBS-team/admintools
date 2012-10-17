class PollMailer < ActionMailer::Base
  default from: "dmitriy.savran@faceit.com.ua"

  def send_poll_mail(poll)
    @poll=poll
    addresses = User.all
    mail(:to => addresses.map(&:email), :subject => "New Poll", :template_path => 'teamleader/poll_mailer',:template_name => 'send_poll_mail')
  end
end
