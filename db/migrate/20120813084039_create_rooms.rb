class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :office
      t.string  :responsible

      t.timestamps
    end

    add_index :rooms, :office

  end
end
