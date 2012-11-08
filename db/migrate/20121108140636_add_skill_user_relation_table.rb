class AddSkillUserRelationTable < ActiveRecord::Migration
  def up
    create_table :skill_user_relations do |t|
      t.integer :user_id
      t.integer :skill_id
      t.integer :score, :default => 0

      t.timestamps
    end
  end

  def down
    drop_table :skill_user_relations
  end
end
