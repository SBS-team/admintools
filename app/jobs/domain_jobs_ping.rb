class DomainJobsPing
  @queue = :domain_jobs_ping

  def self.perform()
    curl = DomainPing.send_ping(Domain.all)
    curl.each_pair do |k, v|
      Domain.find_by_url(k).update_attributes(:active => v)
    end
  end

end