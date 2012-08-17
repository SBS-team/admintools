class AddDesktopsCounterToRoom < ActiveRecord::Migration
  def up
    add_column :rooms, :desktops_count, :integer, :default => 0

    Room.all.each do |r|
      Room.update_counters r.id, :desktops_count => r.desktops.count
    end
  end
  
  def down
    drop_column :rooms, :desktops_count
  end
end