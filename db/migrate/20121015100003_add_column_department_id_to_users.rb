class AddColumnDepartmentIdToUsers < ActiveRecord::Migration
  def up
    add_column :users, :department_id, :integer
  end
end