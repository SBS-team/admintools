class CreatePingLogs < ActiveRecord::Migration
  def change
    create_table :ping_logs do |t|
      t.string :ping_type
      t.integer :ping_id
      t.timestamp :up
      t.timestamp :down
      t.timestamps
    end
    add_index :ping_logs, :ping_id
  end
end
