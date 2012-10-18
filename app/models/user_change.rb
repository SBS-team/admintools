class UserChange < ActiveRecord::Base
  attr_accessible :edited_id, :change,:editor_id,:editor_type,:editor
  serialize :change
  belongs_to :editor, :polymorphic => true
  belongs_to :edited, foreign_key: 'edited_id' , :class_name => 'User'
end
