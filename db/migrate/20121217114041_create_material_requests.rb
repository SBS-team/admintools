class CreateMaterialRequests < ActiveRecord::Migration
  def change
    create_table :material_requests do |t|
      t.string :name
      t.integer :priority
      t.boolean :status
      t.references :user

      t.timestamps
    end
    add_index :material_requests, :user_id
  end
end
