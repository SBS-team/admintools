require "spec_helper"

  describe Event do

    it { should have_many :event_admins }
    it { should have_many(:admins).through(:event_admins) }

    context 'scopes' do
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
  end