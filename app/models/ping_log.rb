class PingLog < ActiveRecord::Base
  belongs_to :ping, :polymorphic => true
  validates :ping_type, :inclusion => { :in => %w{desktop device} }
end
