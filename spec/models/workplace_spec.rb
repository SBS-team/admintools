require "spec_helper"

  describe Workplace do
    it { should belong_to :room_plan }
    it { should belong_to :desktop }
    it { should have_one(:user).through(:desktop) }
  end