class AddMacToPingLogs < ActiveRecord::Migration
  def up
    add_column :ping_logs, :mac, :string
  end
  def down
    remove_column :ping_logs, :mac
  end
end