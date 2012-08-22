class AddAvatarColumnsToUsers < ActiveRecord::Migration
  create_table :users do |t|
    t.attachment :avatar
  end
end
