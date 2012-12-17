class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :priority
      t.date :execution_date
      t.integer :creater_id
      t.integer :user_id
      t.boolean :task

      t.timestamps
    end
  end
end
