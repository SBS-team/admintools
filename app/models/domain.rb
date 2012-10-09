class Domain < ActiveRecord::Base
  has_many :ping_logs, :as => :ping
  self.per_page = 30
  validates :url, :presence => true, :uniqueness => true, :format => {:with => /^(?:http\:[\/]{2}[w]{3}){1}(?:\.[_\-a-zA-Z0-9\/\.]{3,})$/, :massage => 'Wrong URL'}
end