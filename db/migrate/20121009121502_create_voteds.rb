class CreateVoteds < ActiveRecord::Migration
  def change
    create_table :voteds do |t|
      t.integer :poll_id
      t.integer :user_id
      t.integer :option_id
      t.string :option_vote

      t.timestamps
    end
  end
end
