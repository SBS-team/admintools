require "spec_helper"

  describe Event do
    it { should have_many(:event_users) }
    it { should have_many(:users).through(:event_users) }
  end