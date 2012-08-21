class CreateRoomPlans < ActiveRecord::Migration
  def change
    create_table :room_plans do |t|
      t.integer :room_id
      t.integer :width, :default => 0
      t.integer :length, :default => 0
      
      t.timestamps
    end
  end
end
