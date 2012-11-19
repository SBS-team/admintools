#encoding=UTF-8
module ApplicationHelper

  def check_empty(obj,field)
    obj.try(field) || "Пусто"
  end

  def auth_role( role )
    if role.is_a?User
      "пользователя"
    else
      "админстратора"
    end
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
    @admins_list = User.admins.by_name
    @managers_list = User.managers.by_name
    @departments_list = Department.includes(:users).order('departments.id, users.role, users.last_name, users.first_name')
    @out_users_list = User.out_department.by_name
    render :partial => 'teamleader/shared/sidebar'
  end

  def avatar_image_link_tag(user, size = 50)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    link_to "http://gravatar.com", :target => :blank do
      image_tag "http://gravatar.com/avatar/#{gravatar_id}.png?d=wavatar&s=#{size}"
    end
  end
end