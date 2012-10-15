#encoding=UTF-8
module ApplicationHelper

  def check_empty(obj,field)
    obj.try(field) || "Пусто"
  end

  def auth_role( role )
    return "пользователя" if role.is_a?User
    return "админстратора" if role.is_a?Admin
  end

  def login_by_role( role )
    if role.is_a?User
      return link_to "Войти как администратор", admin_root_path
    end
    if role.is_a?Admin
      return link_to "Войти как пользователь", teamleader_root_path
    end
  end

  def auth_page_title( role )
    return "Admintools" if role.is_a?Admin
    return "Team Leader" if role.is_a?User
  end

  def flash_alerts
   flash_messages = []
   flash.each do |type, message|
     type = :success if type == :notice
     type = :error   if type == :alert
     text = content_tag(:div,
              content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
              message, :class => "alert fade in alert-#{type}")
     flash_messages << text if message
   end
   flash_messages.join("\n").html_safe
  end

  def user_list
    @users_list = case current_user.role
    when 'admin'
      User.all
    when 'manager'
      User.for_manager
    when 'teamleader'
      User.for_teamleader(current_user)
    end
    render :partial => 'teamleader/users/sidebar' if @users_list
  end
end