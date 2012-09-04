class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_for_auth
  before_filter :authenticate_admin!

  private
  def layout_for_auth
    if devise_controller?
      "authorization"
    else
      "application"
    end
  end
end
