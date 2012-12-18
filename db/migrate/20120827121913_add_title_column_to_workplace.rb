class AddTitleColumnToWorkplace < ActiveRecord::Migration
  def up
    add_column :workplaces, :title, :string
  end
  def down
    remove_column :workplaces, :title
  end
end
