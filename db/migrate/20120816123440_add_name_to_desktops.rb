class AddNameToDesktops < ActiveRecord::Migration
  def change
    add_column :desktops, :name, :string
  end
end
