class ClearLogs
  @queue = :clear_log

  def self.perform(type=nil, from=nil, to=nil)
    return unless type
    return unless from || to
    puts "run cleaner for #{type}"
    logs = LogCleaner.new(:type => type, :from => from, :to => to)
    logs.clean
    # cleaner.local  if type == "local"
    # cleaner.server if type == "server"
  end

end