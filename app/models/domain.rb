class Domain < ActiveRecord::Base
  has_many :ping_logs, :as => :ping
end
