class DomainJobsPing
  @queue = :domain_jobs_ping

  def self.perform
    @admins = Admin.all
    if DomainPing.send_ping(["http://wwww.google.com.ua", "http://www.rambler.ru", "http://www.yandex.ru"]).has_value?(1)
      if !Domain.where(:check => true).blank?
        Domain.where(:check => true).find_in_batches(:batch_size => 20) do |dom|
          DomainPing.send_ping(dom.map(&:url)).each_pair do |url_key, url_value|
            Domain.find_by_url(url_key).update_attributes(:active => url_value)
            ping_last = PingLog.joins("INNER JOIN domains on domains.id = ping_id").where("domains.url = ?", url_key).order("created_at ASC").last
            if url_value == 1
              if !(!ping_last.try(:up).blank? && ping_last.try(:down).blank?) or PingLog.where(:ping_type => "Domain").blank?
                Domain.find_by_url(url_key).ping_logs.create(:up => Time.zone.now, :status => "ok")
              else
                []
              end
            elsif url_value == 0
              if (ping_last.try(:up).blank? && ping_last.try(:down).blank?) or PingLog.where(:ping_type => "Domain").blank?
                Domain.find_by_url(url_key).ping_logs.create(:down => Time.zone.now, :status => "critical")
                @admins.each do |admin|
                  AdminMailer.send_email_status_critical(admin.email, admin.name, url_key).deliver
                end
              elsif (!ping_last.try(:up).blank? && ping_last.try(:down).blank?)
                Domain.find_by_url(url_key).ping_logs.update_all(:down => Time.zone.now, :status => "critical")
                @admins.each do |admin|
                  AdminMailer.send_email_status_critical(admin.email, admin.name, url_key).deliver
                end
              else
                []
              end
            end
          end
        end
      else
        []
      end
    else
      if PingLog.where(:ping_type => "Domain").blank?
        Domain.all.each do |dom|
          dom.ping_logs.create(:down => Time.zone.now, :status => "critical")
          @admins.each do |admin|
            AdminMailer.send_email_status_no_inet(admin.email, admin.name, dom.url).deliver
          end
        end
      else
        PingLog.where(:ping_type => "Domain").group(:ping_id, :updated_at).last(Domain.all.size).each do |obj|
          if obj.down.blank?
            obj.update_attributes(:down => Time.zone.now, :status => "critical")
            @admins.each do |admin|
              AdminMailer.send_email_status_no_inet(admin.email, admin.name, obj.ping.url).deliver
            end
          else
            []
          end
        end
      end
    end
  end
end

