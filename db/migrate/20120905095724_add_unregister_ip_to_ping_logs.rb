class AddUnregisterIpToPingLogs < ActiveRecord::Migration
  def up
    add_column :ping_logs, :unregister_ip, :string
  end
  def down
    remove_column :ping_logs, :unregister_ip
  end
end
