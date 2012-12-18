class CreateUserChanges < ActiveRecord::Migration
  def change
    create_table :user_changes do |t|
      t.integer :edited_id
      t.references :editor, :polymorphic => true
      t.text :change
      t.timestamps
    end
  end
end
