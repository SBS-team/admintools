require "spec_helper"

  describe Event do
    it { should have_many :event_admins }
    it { should have_many(:admins).through(:event_admins) }
  end