class Subnetwork < ActiveRecord::Base
  validates :network, :presence => true, :uniqueness => true,
  :format => {:with => /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.([0]{1})$/, :massage => 'Wrong IP'}
end
