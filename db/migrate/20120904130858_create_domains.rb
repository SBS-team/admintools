class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :url
      t.boolean :check, :default => true
      t.integer :active, :default => -1
      t.text :description

      t.timestamps
    end
  end
end
