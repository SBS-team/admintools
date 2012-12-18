module UserChangesHelper

  def editor_name(user)
    user.respond_to?(:name) ? user.name : user.respond_to?(:full_name) ? user.full_name : "undefined"
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