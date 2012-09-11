class DomainJobsPing
  @queue = :domain_jobs_ping

  def self.perform
    if DomainPing.send_ping(["http://www.google.com.ua","http://www.rambler.ru"]).has_value?(1)
      Domain.where(:check => true).find_in_batches(:batch_size => 20) do |dom|
        DomainPing.send_ping(dom.map(&:url)).each_pair do |k, v|
          Domain.find_by_url(k).update_attributes(:active => v)
          #log if v==false
        end
      end
    else
      #no inet connection, log
    end
  end

end