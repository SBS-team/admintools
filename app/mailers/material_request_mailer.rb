class MaterialRequestMailer < ActionMailer::Base
  default from: "LTD FaceIT <emailfaceit@gmail.com>"

  def send_material_request(material_requests)
    @material_requests = material_requests
    mail(:to => User.admins.map(&:email), :subject => t(:'teamleader.mailer.time_request_mailer.new_request'), :template_path => 'teamleader/material_request_mailer', :template_name => 'send_material_request')
  end

  def material_request_response(material_request)
    @material_request = material_request
    #mail(:to => material_request.user.email, :subject => t(:'teamleader.mailer.time_request_mailer.request_response'), :template_path => 'teamleader/material_request_mailer', :template_name => 'material_request_response')
    mail(:to => "jeyboy1985@gmail.com", :subject => t(:'teamleader.mailer.time_request_mailer.request_response'), :template_path => 'teamleader/material_request_mailer', :template_name => 'material_request_response')
  end
end
