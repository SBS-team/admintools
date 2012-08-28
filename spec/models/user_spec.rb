require "spec_helper"

  describe User do
    it { should have_one :desktop }
    it { should have_many :devices }
    it { should have_one(:room).through(:desktop) }
    it { should have_many(:event_users) }
    it { should have_many(:events).through(:event_users) }
  end