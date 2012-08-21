class CreateWorkplaces < ActiveRecord::Migration
  def change
    create_table :workplaces do |t|
      t.integer :desktop_id
      t.integer :room_plan_id
      t.string  :workplace_type
      t.string  :workplace_form
      t.integer :top, :default => 0
      t.integer :left, :default => 0
      t.timestamps
    end

    add_index :workplaces, :desktop_id
    add_index :workplaces, :room_plan_id
  end
end