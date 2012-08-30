class Desktop < ActiveRecord::Base
  self.per_page = 10
  after_save :re_counter

  belongs_to :room, :counter_cache => true
  belongs_to :user
  has_one :workplace, :dependent => :nullify

  validates :ip,  :presence => true, :uniqueness => true, :format => {:with => /\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/, :massage => 'Wrong IP'}
  validates :mac, :presence => true, :uniqueness => true, :format => {:with => /\b([A-Fa-f0-9]{2}[:-]){5}[A-Fa-f0-9]{2}\b/, :massage => 'Wrong MAC'}
  validates :user_id, :uniqueness => true, :if => :user_id?
  validates :name, :presence => true

  after_save :re_counter

  private

  def re_counter
    Room.all.each do |r|
      Room.update r.id, :desktops_count => r.desktops.count
    end
  end
end