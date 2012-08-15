class CreateGadgets < ActiveRecord::Migration
  def change
    create_table :gadgets do |t|
      t.string :ip
      t.string :mac
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
