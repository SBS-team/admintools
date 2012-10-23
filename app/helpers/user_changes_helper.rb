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
      Department.with_deleted.find(value).name if value
    when 'manager_id'
      User.with_deleted.find(value).full_name if value
    when 'info'
      value.html_safe
    else
      value
    end
  end
end