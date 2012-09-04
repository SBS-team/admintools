require "spec_helper"

  describe Device do
    let!(:device){ FactoryGirl.create :device }

    it { should belong_to :user }

    it { should validate_uniqueness_of(:ip) }
    it { should validate_presence_of(:ip) }
    it { should validate_uniqueness_of(:mac) }
    it { should validate_presence_of(:mac) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:user_id) }
  end