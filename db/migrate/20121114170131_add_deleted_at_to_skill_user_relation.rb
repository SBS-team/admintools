class AddDeletedAtToSkillUserRelation < ActiveRecord::Migration
  def change
    add_column :skill_user_relations, :deleted_at, :datetime
  end
end
