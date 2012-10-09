class AddStatusToPingLog < ActiveRecord::Migration
  def change
    add_column :ping_logs, :status, :string
  end
end
