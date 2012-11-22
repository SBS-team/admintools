class CreateVacations < ActiveRecord::Migration
  def change
    create_table :vacations do |t|
      t.integer :user_id
      t.integer :month
      t.integer :year
      t.integer :day_from
      t.integer :day_to
      t.boolean :approved, :default => false

      t.timestamps
    end
  end
end
