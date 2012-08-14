class AddRoomIdToDesktop < ActiveRecord::Migration
  def change
    add_column :desktops, :room_id, :integer
  end
end
