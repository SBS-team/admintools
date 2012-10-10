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
      return link_to "Войти как пользователь", root_path
    end
  end

  def auth_page_title( role )
    return "Admintools" if role.is_a?Admin
    return "Team Leader" if role.is_a?User
  end
end