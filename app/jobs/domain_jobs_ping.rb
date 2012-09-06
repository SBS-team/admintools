class DomainJobsPing
  @queue = :domain_jobs_ping

  def self.perform()
    Domain.find_in_batches(:batch_size => 2) do |dom|
      curl = DomainPing.send_ping(dom)
      curl.each_pair do |k, v|
        Domain.find_by_url(k).update_attributes(:active => v)
      end
    end
  end

end