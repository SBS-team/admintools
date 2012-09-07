#encoding=UTF-8
module DomainsHelper

  def check_true_or_false(obj)
    if obj.active == false && obj.check == false
      "Нет информации"
    else
      if obj.active
        "Активен"
      else
        "Не активен"
      end
    end
  end
end
