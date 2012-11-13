class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :manager_id
      t.integer :managed_id

      t.timestamps
    end

    add_index :relationships, :manager_id
    add_index :relationships, :managed_id
    add_index :relationships, [:manager_id, :managed_id], unique: true
  end
end
