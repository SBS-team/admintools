class Desktop < ActiveRecord::Base
  before_save :dec_counter
  after_save :inc_counter
  
  attr_accessible :info, :ip, :mac, :name

  belongs_to :room, :counter_cache => true
  belongs_to :user

  validates :ip,  :presence => true, :uniqueness => true, :format => {:with => /\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/, :massage => 'Wrong IP'}
  validates :mac, :presence => true, :uniqueness => true, :format => {:with => /\b([A-Fa-f0-9]{2}[:-]){5}[A-Fa-f0-9]{2}\b/, :massage => 'Wrong MAC'}
  validates :user_id, :uniqueness => true, :if => :user_id?
  validates :name, :presence => true

  private

  def dec_counter
    Room.update(room_id, {:desktops_count => Room.find(room_id).desktops.count - 1}) if :room_id?
  end

  def inc_counter
    Room.update(room_id, {:desktops_count => Room.find(room_id).desktops.count + 1}) if :room_id?
  end
end