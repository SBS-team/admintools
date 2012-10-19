module UserChangesHelper

  def editor_name(user)
    if user.is_a?Admin
      user.name
    else
      user.full_name
    end
  end

  def print_changes(field, value)
    case field
    when 'department_id'
      Department.find(value).name
    when 'manager_id'
      User.find(value).full_name if value
    when 'info'
      value.html_safe
    else
      value
    end
  end
end