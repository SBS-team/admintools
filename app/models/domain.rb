class Domain < ActiveRecord::Base
  has_many :ping_logs, :as => :ping

  self.per_page = 10
end
