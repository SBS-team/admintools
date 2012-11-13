class Relationship < ActiveRecord::Base
  attr_accessible :managed_id, :manager_id

  belongs_to :manager, class_name: 'User'
  belongs_to :managed, class_name: 'User'
  validates_presence_of :manager_id, :managed_id
  validates_uniqueness_of :manager_id, scope: [:managed_id]
  validate do
    if self.managed_id.present? && self.managed_id == self.manager_id
      errors.add(:managed_id, 'manager can\'t managee themself.')
    end
  end
end
