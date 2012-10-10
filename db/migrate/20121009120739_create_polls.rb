class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :question
      t.string :option
      t.integer :max_votes
      t.datetime :end_at

      t.timestamps
    end
  end
end
