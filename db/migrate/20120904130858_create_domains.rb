class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :url
      t.boolean :check
      t.boolean :active
      t.text :description

      t.timestamps
    end
  end
end
