require "spec_helper"

  describe Room do
    it "should have 0 desktops_count in the room when create it" do
      room = FactoryGirl.create :room
      room.desktops_count.should eq 0
    end
  end