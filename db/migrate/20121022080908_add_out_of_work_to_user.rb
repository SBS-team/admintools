class AddOutOfWorkToUser < ActiveRecord::Migration
  def up
    add_column :users, :out_of_work, :timestamp
  end

  def down
    remove_column :users, :out_of_work
  end
end