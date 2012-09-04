require "spec_helper"

  describe User do
    let!(:user){ FactoryGirl.create :user }

    it { should have_one :desktop }
    it { should have_many :devices }
    it { should have_one(:room).through(:desktop) }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:skype) }

    it 'user have a fullname' do
      user.full_name.should eq "Vasya Ivanov"
    end
  end