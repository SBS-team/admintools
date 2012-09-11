module LocalPing
  @queue = :local_ping
  def self.perform()
    Ping.multiecho(Desktop.all + Device.all)
  end
end