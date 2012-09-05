class PingLog < ActiveRecord::Base
  belongs_to :ping, :polymorphic => true
  validates :ping_type, :inclusion => { :in => %w{Desktop Desktops Device Devices} }
end
