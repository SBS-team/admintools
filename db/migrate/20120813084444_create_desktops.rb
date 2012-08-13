class CreateDesktops < ActiveRecord::Migration
  def change
    create_table :desktops do |t|
      t.string  :ip
      t.string  :mac
      t.text    :info
      t.integer :user_id

      t.timestamps
    end

    add_index :desktops, :user_id

  end
end
