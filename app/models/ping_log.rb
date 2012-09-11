class PingLog < ActiveRecord::Base
  self.per_page = 30
  belongs_to :ping, :polymorphic => true
  # validates :ping_type, :inclusion => { :in => %w{Desktop Device} }, :if => :ping_type?
end
