class UserChange < ActiveRecord::Base
  self.per_page = 20
  attr_accessible :edited_id, :change, :editor_id, :editor_type, :editor
  serialize :change
  belongs_to :editor, :polymorphic => true
  belongs_to :edited, :foreign_key => 'edited_id', :class_name => 'User'

  scope :subordinates, lambda { |u| joins("LEFT JOIN users u ON u.id = user_changes.edited_id").where('u.role= ? AND u.department_id=?', 'user', u.department_id).includes(:edited,:editor) }
end
