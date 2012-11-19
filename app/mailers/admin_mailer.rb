#encoding=UTF-8
class AdminMailer < ActionMailer::Base

  default from: "LTD FaceIT <emailfaceit@gmail.com>"

  def send_event_email(admin,event)
    @event = event
    mail(:to => admin.email, :subject => event.title)
    puts "sended to #{admin.email}"
  end

  def send_email_status_critical(email, name, url_name)
    @name = name
    @url_name = url_name
    mail(:to => email, :subject => "Статус #{@url_name} изменился")
  end

  def send_email_status_no_inet(email, name, url_name)
    @name = name
    @url_name = url_name
    mail(:to => email, :subject => "Подключение к интернету отсутствует")
  end

end
