class AddDeletedAtToDepartment < ActiveRecord::Migration
  def up
    add_column :departments, :deleted_at, :datetime
  end
end
