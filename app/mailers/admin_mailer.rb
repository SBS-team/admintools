#encoding=UTF-8
class AdminMailer < ActionMailer::Base

  default from: "scheduler@faceit.com.ua"

  def send_event_email(admin,event)
    @event = event
    mail(:to => admin.email, :subject => event.title)
    puts "sended to #{admin.email}"
  end

  def send_email_to_admin(email)
    mail(:to => email, :subject => "Что-то изменилось")
  end

end
