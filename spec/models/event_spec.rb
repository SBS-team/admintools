require "spec_helper"

  describe Event do

    it { should have_many :event_admins }
    it { should have_many(:admins).through(:event_admins) }

    context 'starts_at_is_less_than_ends_at' do
      before(:each) do
        @event1 = FactoryGirl.build :event, :starts_at => Time.now + 1.day
        @event2 = FactoryGirl.create :event
      end

      it "should return correct event" do
        @event1.starts_at_is_less_than_ends_at
        @event1.errors.messages.to_s.should match "should be less than ends_at"
      end

      it "should return incorrect event" do
        @event2.starts_at_is_less_than_ends_at
        @event2.errors.messages.should be_blank
      end
    end

    context 'format' do
      before(:each) do
        @event = Event.format_date("1347224400")
      end

      it "should return correct format_date" do
        @event.should == "2012-09-10 00:00:00"
      end
    end
  end