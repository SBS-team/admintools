class CreateEventAdmins < ActiveRecord::Migration
  def change
    create_table :event_admins do |t|
      t.references :admin
      t.references :event

      t.timestamps
    end
  end
end
