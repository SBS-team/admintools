class ClearLogs
  @queue = :clear_log

  def self.perform(from=nil, to=nil)
    return unless from || to
    if (from && to)
      RedisTools.clear_by_log(PingLog.local.where(:created_at => from..to).destroy_all)
    elsif (from && to.nil?)
      RedisTools.clear_by_log(PingLog.local.from_date(from).destroy_all)
    elsif (from.nil? && to)
      RedisTools.clear_by_log(PingLog.local.to_date(to).destroy_all)
    end
  end

end