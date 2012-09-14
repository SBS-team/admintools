class DomainJobsPing
  @queue = :domain_jobs_ping

  def self.perform
    if DomainPing.send_ping(["http://wwww.google.com.ua","http://wwww.rambler.ru"]).has_value?(1)
      Domain.where(:check => true).find_in_batches(:batch_size => 20) do |dom|
        DomainPing.send_ping(dom.map(&:url)).each_pair do |url_key, url_value|
          Domain.find_by_url(url_key).update_attributes(:active => url_value)

          ping_last = PingLog.joins("INNER JOIN domains on domains.id = ping_id").where("domains.url = ?", url_key).order("created_at ASC").last
          if url_value == 1
            if PingLog.where(:ping_type => "Domain").blank? or !(!ping_last.up.blank? && ping_last.down.blank?)
              Domain.find_by_url(url_key).ping_logs.create(:up => Time.now, :status => "ok")
            end
          elsif url_value == 0
            if PingLog.where(:ping_type => "Domain").blank? or (ping_last.up.blank? && ping_last.down.blank?)
              Domain.find_by_url(url_key).ping_logs.create(:down => Time.now, :status => "critical")
            elsif (!ping_last.up.blank? && ping_last.down.blank?)
              Domain.find_by_url(url_key).ping_logs.update_all(:down => Time.now, :status => "critical")
            end
          end
        end
      end
    else
      PingLog.where(:ping_type => "Domain", :down => nil).group(:ping_id, :updated_at).last(Domain.all.size).each do |obj|
        if obj.up.blank?
          obj.ping.ping_logs.create(:down => Time.now, :status => "critical")
        else
          obj.update_attributes(:down => Time.now)
        end
        puts "*"*100
      end
    end
  end
end