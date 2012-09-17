#encoding=UTF-8
require "curb"

class DomainPing
  def self.send_ping(all_url)
    curl = {}
    Curl::Multi.get( all_url, :follow_location => true) do |easy|
      begin
        easy.connect_timeout = 5
        if (easy.response_code >= 200 && easy.response_code < 300)
          curl[easy.url] = 1
        else
          curl[easy.url] = 0
        end
      rescue Exception
        {}  #выполнить запись в логи список урл, для дальнейшей отладки
      end
    end
    curl
  end
end
