class CreateVacations < ActiveRecord::Migration
  def change
    create_table :vacations do |t|
      t.integer :user_id
      t.date :date_from
      t.date :date_to
      t.boolean :approved, :default => false

      t.timestamps
    end
  end
end
