class CreateTimeRequest < ActiveRecord::Migration
  #user_id:integer month:integer year:integer requested_time:integer approved:boolean
  def change
    create_table :time_requests do |t|
      t.references :user
      t.date :request_date
      t.integer :requested_time
      t.text :message
      t.boolean :approved

      t.timestamps
    end
  end
end
