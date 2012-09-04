require "spec_helper"

  describe Desktop do
    let!(:desktop){ FactoryGirl.create :desktop }

    it { should belong_to :room }
    it { should belong_to :user }
    it { should have_one(:workplace).dependent(:nullify) }

    it { should validate_uniqueness_of(:ip) }
    it { should validate_presence_of(:ip) }
    it { should validate_uniqueness_of(:mac) }
    it { should validate_presence_of(:mac) }
    it { should validate_uniqueness_of(:user_id) }
    it { should validate_presence_of(:name) }

    context "creating room" do
      before :each do
        @room = FactoryGirl.create :room
        5.times {FactoryGirl.create :desktop, :room => @room}
      end
      it "should create room with desktops_count eq 5" do
        @room.reload.desktops_count.should == 5
      end
    end
  end