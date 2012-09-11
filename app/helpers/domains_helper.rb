#encoding=UTF-8
module DomainsHelper

  def check_true_or_false(obj)
    case obj.active
      when -1
        "Нет информации"
      when 0
        "Не активен"
      when 1
        "Активен"
      else
        {}
    end
  end
end
