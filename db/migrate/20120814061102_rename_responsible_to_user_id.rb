class RenameResponsibleToUserId < ActiveRecord::Migration
  def change
    remove_column :rooms, :responsible
    add_column :rooms, :user_id, :integer
  end

end
