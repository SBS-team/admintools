# encoding: UTF-8
module NavigationHelpers
  def path_to(page_name)
    case page_name

      when /the admin login/
        visit new_admin_session_path

      when /Пользователи/
        visit admin_users_path

      when /Офисы/
        visit admin_rooms_path
        sleep(5)

      when /Создать button to user create/
        visit new_admin_user_path

      when /Создать button to room create/
        visit new_admin_room_path
        sleep(5)

      else
        raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World(NavigationHelpers)