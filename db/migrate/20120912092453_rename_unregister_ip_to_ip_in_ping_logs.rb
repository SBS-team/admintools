class RenameUnregisterIpToIpInPingLogs < ActiveRecord::Migration
  def up
    rename_column :ping_logs, :unregister_ip, :ip
  end

  def down
  end
end
