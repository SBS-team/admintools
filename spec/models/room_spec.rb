require "spec_helper"

  describe Room do
    it { should belong_to :user }
    it { should have_many :desktops }
    it { should have_one :room_plan }
    it { should have_many(:users).through(:desktops) }
    it { should have_many(:workplaces).through(:room_plan) }
  end