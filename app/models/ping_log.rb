class PingLog < ActiveRecord::Base
  self.per_page = 30
  belongs_to :ping, :polymorphic => true
  validates :ping_type, :inclusion => { :in => %w{Desktop Device Domain} }, :if => :ping_type?

  scope :get_by_ip, lambda { |ip| where("ip=?", ip) }
  scope :local, lambda { where("(`ping_type` IN ('Desktop', 'Device') OR `ping_type` IS NULL)") }
  scope :by_range, lambda { |d, cond| where("created_at #{cond} ?", d) }
  scope :from_date, lambda { |d| where("created_at > ?", d) }
  scope :to_date, lambda { |d| where("created_at < ?", d) }
end