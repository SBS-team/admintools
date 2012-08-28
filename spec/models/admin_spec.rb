require "spec_helper"

describe Admin do
  let(:admin){FactoryGirl.create :admin}

  it "should return correct value for constant Admin::SUPER_ADMIN " do
    Admin::SUPER_ADMIN.should == "admin"
  end

  context "is_super_admin?" do
    before :each do
      @super_admin = FactoryGirl.create :super_admin
    end

    it "should check current admin is super admin" do
      admin.is_super_admin?.should be_false
      @super_admin.is_super_admin?.should be_true
    end
  end

end