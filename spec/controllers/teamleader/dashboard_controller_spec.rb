require 'spec_helper'

describe Teamleader::DashboardController do
  describe 'index' do
    it 'as user' do
      sign_in (@user = FactoryGirl.create(:user, :role => "user"))
      get :index
      assigns(:polls).should eq Poll.order("created_at DESC")
    end

    it 'as teamleader' do
      sign_in (@user = FactoryGirl.create(:teamleader))
      get :index
      assigns(:without_job).should eq User.out_of_work
      assigns(:last_logs).should eq UserChange.subordinates(@user).order('user_changes.created_at DESC').limit 10
      assigns(:absents).should eq User.subordinates(Absent.actual_absents(Time.zone.now.midnight.to_s(:db)), @user)
    end

    it 'as other roles' do
      sign_in (@user = FactoryGirl.create(:manager))
      get :index
      assigns(:last_logs).should eq UserChange.includes([:editor,:edited]).order('user_changes.created_at DESC').limit 10
      assigns(:absents).should eq Absent.actual_absents(Time.zone.now.midnight.to_s(:db))

      #assigns(:birthdays).should eq
    end

    after(:each) {sign_out @user}
  end
end