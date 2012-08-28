class AddTitleColumnToWorkplace < ActiveRecord::Migration
  def up
    add_column :workplaces, :title, :string
  end
  def down
    destroy_column :workplaces, :title
  end
end
