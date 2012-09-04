require "spec_helper"

  describe Room do
    let!(:room){ FactoryGirl.create :room }

    it { should belong_to :user }
    it { should have_many :desktops }
    it { should have_one :room_plan }
    it { should have_many(:users).through(:desktops) }
    it { should have_many(:workplaces).through(:room_plan) }

    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:user_id) }
    it { should validate_presence_of(:user_id) }
  end