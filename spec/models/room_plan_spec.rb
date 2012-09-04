require "spec_helper"

  describe RoomPlan do
    it { should belong_to :room }
    it { should have_many :workplaces }
    it { should have_many(:desktops).through(:workplaces) }

    context "creating room" do
      before :each do
        @room = FactoryGirl.create :room
        @room_plan = FactoryGirl.create :room_plan, :room => @room
      end
      it "should create room with id eq room_id" do
        @room.reload.id.should == @room_plan.room_id
      end
    end
  end