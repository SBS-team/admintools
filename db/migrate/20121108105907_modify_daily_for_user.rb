class ModifyDailyForUser < ActiveRecord::Migration
  def up
    rename_column :users, :daily, :daily_0
    (1..6).each {|d| add_column :users, "daily_#{d}".to_sym, :string}
  end

  def down
    (1..6).to_a.each {|d| remove_column :users, "daily_#{d}".to_sym, :string}
    rename_column :users, :daily_0, :daily
  end
end
