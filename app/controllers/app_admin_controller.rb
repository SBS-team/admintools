class AppAdminController < ActionController::Base
  protect_from_forgery
  layout :layout_for_auth
  before_filter :authenticate_admin!
  before_filter :set_locale

  def set_locale
    # Если params[:locale] равно nil, то будет использовано I18n.default_locale
    I18n.locale = params[:locale]
  end

  private
  def layout_for_auth
    if devise_controller?
      "authorization"
    else
      "application"
    end
  end
end