class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_for_auth
  before_filter :authenticate_user!
  before_filter :set_locale

  def after_sign_in_path_for(resource)
    if resource.is_a?User
      if resource.is_user?
        teamleader_root_path
      else
        teamleader_dashboard_index_path
      end
    else
      admin_root_path
    end
  end

  def set_locale
    I18n.locale = params[:locale]
  end

  private

  def layout_for_auth
    if devise_controller?
      "authorization"
    else
      "team_leader"
    end
  end
end