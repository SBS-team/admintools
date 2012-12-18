class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :priority, :default => "medium"
      t.date :execution_date
      t.integer :creator_id
      t.integer :user_id
      t.boolean :task, :default => false

      t.timestamps
    end
  end
end
