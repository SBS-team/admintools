class Admin::AppAdminController < ActionController::Base
  protect_from_forgery
  layout :layout_for_auth
  before_filter :authenticate_admin!
  before_filter :set_locale

  def set_locale
    # Если params[:locale] равно nil, то будет использовано I18n.default_locale
    I18n.locale = params[:locale]
  end

  def birthday(date)
    "#{date.day} #{t("date.month_names")[date.month]}" rescue "date not set"
  end
  helper_method :birthday

  private
  def layout_for_auth
    if devise_controller?
      "authorization"
    else
      "application"
    end
  end
end