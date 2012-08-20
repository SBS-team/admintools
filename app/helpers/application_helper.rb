#encoding=UTF-8
module ApplicationHelper

  def check_empty(obj,field)
    obj.try(field) || "Пусто"
  end

end
