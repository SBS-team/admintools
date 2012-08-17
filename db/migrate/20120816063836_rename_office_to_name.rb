class RenameOfficeToName < ActiveRecord::Migration
  def change
    rename_column :rooms, :office, :name
    change_column :rooms, :name, :string
  end

  def down
  end
end
