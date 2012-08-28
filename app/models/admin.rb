class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :title, :body
  has_many :event_admins
  has_many :events, :through => :event_admins

  def user_tokens=(ids)
    self.user_ids = ids.split(",")
  end
end
