class CreateTimeRequest < ActiveRecord::Migration
  #user_id:integer month:integer year:integer requested_time:integer approved:boolean
  def change
    create_table :time_requests do |t|
      t.references :user
      t.integer :date
      t.integer :requested_time
      t.text :message
      t.boolean :approved, :default => false

      t.timestamps
    end
  end
end
