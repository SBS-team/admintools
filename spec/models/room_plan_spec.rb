require "spec_helper"

  describe RoomPlan do
    it { should belong_to :room }
    it { should have_many :workplaces }
    it { should have_many(:desktops).through(:workplaces) }
  end