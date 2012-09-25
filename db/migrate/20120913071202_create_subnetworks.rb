class CreateSubnetworks < ActiveRecord::Migration
  def change
    create_table :subnetworks do |t|
      t.string :network, :null => false
      t.timestamps
    end
  end
end
