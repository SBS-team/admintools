#encoding=UTF-8
require "curb"

class DomainPing
  def self.send_ping(all_url)
    curl = {}
    Curl::Multi.get( all_url, :follow_location => true) do |easy|
      begin
        easy.connect_timeout = 5
        curl[easy.url] = (easy.response_code >= 200 && easy.response_code < 300)
      rescue Exception
        {}  #выполнить запись в логи список урл, для дальнейшей отладки
      end
    end
    curl
  end


  #def self.send_ping(all_url)
  #  curl = {}
  #  curl = Curl::Multi.get( all_url, :follow_location => true)
  #    begin
  #      curl.connect_timeout = 5
  #      curl[url] = (curl.easy.response_code >= 200 && curl.response_code < 300)
  #    rescue Exception
  #      {}  #выполнить запись в логи список урл, для дальнейшей отладки
  #    end
  #  curl
  #end
end
