require "spec_helper"

describe Admin do
  before :each do
    FactoryGirl.create :admin
  end

  it { should have_db_column(:id).of_type('integer')}
  it { should have_db_column(:sign_in_count).of_type('integer')}
  it { should have_db_column(:email).of_type('string')}
  it { should have_db_column(:encrypted_password).of_type('string')}
  it { should have_db_column(:reset_password_token).of_type('string')}
  it { should have_db_column(:current_sign_in_ip).of_type('string')}
  it { should have_db_column(:last_sign_in_ip).of_type('string')}
  it { should have_db_column(:name).of_type('string')}
  it { should have_db_column(:reset_password_sent_at).of_type('datetime')}
  it { should have_db_column(:remember_created_at).of_type('datetime')}
  it { should have_db_column(:last_sign_in_at).of_type('datetime')}
  it { should have_db_column(:created_at).of_type('datetime')}
  it { should have_db_column(:updated_at).of_type('datetime')}
  it { should have_db_column(:deleted_at).of_type('datetime')}
  it { should have_many :event_admins }
  it { should have_many(:events).through(:event_admins) }
  it { should have_many(:users_change), :as=>:editor,:class_name => 'UserChange' }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:email) }

  it "should return correct value for constant Admin::SUPER_ADMIN " do
    Admin::SUPER_ADMIN.should == "admin"
  end

  context "is_super_admin?" do
    before(:each) do
      @super_admin = FactoryGirl.create :super_admin
    end

    it "should check current admin is super admin" do
      FactoryGirl.create(:admin).is_super_admin?.should be_false
      @super_admin.is_super_admin?.should be_true
    end
  end

end