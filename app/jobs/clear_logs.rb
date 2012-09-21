class ClearLogs
  @queue = :clear_log

  def self.perform(type=nil, from=nil, to=nil)
    return unless type
    return unless from || to
    logs = LogCleaner.new(:type => type, :from => from, :to => to)
    logs.clean
  end

end