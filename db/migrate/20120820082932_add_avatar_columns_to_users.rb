class AddAvatarColumnsToUsers < ActiveRecord::Migration
  change_table :users do |t|
    add_column :users, :avatar_file_name ,    :string
    add_column :users, :avatar_content_type,  :string
    add_column :users, :avatar_file_size,     :integer
    add_column :users, :avatar_updated_at,    :datetime
  end
end
