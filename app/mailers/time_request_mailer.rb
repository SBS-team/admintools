class TimeRequestMailer < ActionMailer::Base
  default from: "LTD FaceIT <emailfaceit@gmail.com>"

  def send_time_request(time_request)
    @time_request=time_request
    #mail(:to => User.admins.map(&:email), :subject => t(:'teamleader.mailer.poll_mailer.new_poll'), :template_path => 'teamleader/poll_mailer', :template_name => 'send_poll_mail')
    mail(:to => "jeyboy1985@gmail.com", :subject => t(:'teamleader.mailer.time_request_mailer.new_request'), :template_path => 'teamleader/time_request_mailer', :template_name => 'send_time_request')
  end
end
