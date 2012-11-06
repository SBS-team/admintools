class ChangeBirthdayInUser < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.change :birthday, :date, :null => nil
    end
  end
end