class ModifyDailyForUser < ActiveRecord::Migration
  def up
    rename_column :users, :daily, :daily_1
    (2..7).each {|d| add_column :users, "daily_#{d}".to_sym, :string}
  end

  def down
    (2..7).to_a.each {|d| remove_column :users, "daily_#{d}".to_sym}
    rename_column :users, :daily_1, :daily
  end
end
