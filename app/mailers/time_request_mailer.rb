class TimeRequestMailer < ActionMailer::Base
  default from: "LTD FaceIT <emailfaceit@gmail.com>"

  def send_time_request(time_request)
    @time_request=time_request
    mail(:to => User.admins.map(&:email), :subject => t(:'teamleader.mailer.time_request_mailer.new_request'), :template_path => 'teamleader/time_request_mailer', :template_name => 'send_time_request')
  end

  def time_request_response(time_request, old_time = nil)
    @time_request=time_request
    @old_time = old_time
    mail(:to => time_request.user.email, :subject => t(:'teamleader.mailer.time_request_mailer.request_response'), :template_path => 'teamleader/time_request_mailer', :template_name => 'time_request_response')
  end
end
