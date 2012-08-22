class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_for_auth

  private
  def layout_for_auth
    if devise_controller?
      "authorization"
    else
      "application"
    end
  end
end
