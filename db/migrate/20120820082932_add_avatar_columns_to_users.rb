class AddAvatarColumnsToUsers < ActiveRecord::Migration
  change_table :users do |t|
    t.attachment :avatar
  end
end
