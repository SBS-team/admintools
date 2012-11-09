class AddSkillTable < ActiveRecord::Migration
  def up
    create_table :skills do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :skills
  end
end
