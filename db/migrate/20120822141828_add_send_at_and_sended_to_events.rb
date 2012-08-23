class AddSendAtAndSendedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :send_at, :datetime
    add_column :events, :sended, :boolean, :default => false
  end
end
