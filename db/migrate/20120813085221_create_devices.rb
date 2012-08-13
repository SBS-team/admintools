class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :ip
      t.string :mac
      t.integer :user_id

      t.timestamps
    end

    add_index :devices, :user_id

  end
end
