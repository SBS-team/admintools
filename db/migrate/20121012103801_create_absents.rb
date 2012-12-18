class CreateAbsents < ActiveRecord::Migration
  def change
    create_table :absents do |t|
      t.references :user
      t.string :reason
      t.datetime :date_from
      t.datetime :date_to
      t.timestamps
    end
  end
end
