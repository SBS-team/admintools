class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :user
      t.text :body
      t.boolean :report_send, :default=>false

      t.timestamps
    end
  end
end
