class ChangeUsersTable < ActiveRecord::Migration
  def up
    change_table(:users) do |t|
      ## Database authenticatable
      t.date :birthday,   :null => false
      t.string :employer
      t.string :odesk
      t.string :daily
    end
  end

  def down
  end
end
