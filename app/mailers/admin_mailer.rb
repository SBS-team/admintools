#encoding=UTF-8
class AdminMailer < ActionMailer::Base

  default from: "LTD FaceIT <emailfaceit@gmail.com>"

  def send_event_email(admin,event)
    @event = event
    mail(:to => admin.email, :subject => event.title, :template_path => 'admin/admin_mailer',:template_name => 'send_event_email')
    puts "sended to #{admin.email}"
  end

  def send_email_status_critical(email, name, url_name)
    @name = name
    @url_name = url_name
    mail(:to => email, :subject => "Статус #{@url_name} изменился", :template_path => 'admin/admin_mailer',:template_name => 'send_email_status_critical')
  end

  def send_email_status_no_inet(email, name, url_name)
    @name = name
    @url_name = url_name
    mail(:to => email, :subject => "Подключение к интернету отсутствует", :template_path => 'admin/admin_mailer',:template_name => 'send_email_status_no_inet')
  end

  def send_email_to_the_added_user(user)
    @user = user
    mail(:to => user.email, :subject => "Выбыли добавлены на сайт admintools.loc ", :template_path => 'admin/admin_mailer',:template_name => 'send_email_to_the_added_user')
  end

end