class CreateLocalPings < ActiveRecord::Migration
  def change
    create_table :local_pings do |t|
      t.integer :desktop_id
      t.timestamp :up, :default => Time.now
      t.timestamp :down
      t.timestamps
    end
    add_index :local_pings, :desctop_id
  end
end
