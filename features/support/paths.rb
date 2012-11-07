# encoding: UTF-8
module NavigationHelpers
  def path_to(page_name)
    case page_name

      when /the admin login/
        visit new_admin_session_path

      when /Пользователи/
        visit admin_users_path

      when /Создать/
        visit new_admin_user_path

      else
        raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World(NavigationHelpers)