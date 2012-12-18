require 'spec_helper'

describe Absent do
  subject { FactoryGirl.create :absent }

  it { should have_db_column(:id).of_type('integer')}
  it { should have_db_column(:user_id).of_type('integer')}
  it { should have_db_column(:reason).of_type('string')}
  it { should have_db_column(:date_from).of_type('datetime')}
  it { should have_db_column(:date_to).of_type('datetime')}
  it { should have_db_column(:created_at).of_type('datetime')}
  it { should have_db_column(:updated_at).of_type('datetime')}
  it { should_not allow_mass_assignment_of([:id, :created_at, :updated_at]) }
  #it { should allow_mass_assignment_of([:reason, :user_id, :date_from, :date_to]) }
  it { should allow_mass_assignment_of(:reason) }
  it { should allow_mass_assignment_of(:user_id) }
  it { should allow_mass_assignment_of(:date_from) }
  it { should allow_mass_assignment_of(:date_to) }
  it { should validate_presence_of(:reason) }
  it { should allow_value(1.day.ago).for(:date_from) }
  it { should_not allow_value(3.day.from_now).for(:date_from) }
  it { should belong_to :user }

  context "actual_absents" do
    it{ Absent.actual_absents(subject.date_from).should include(subject) }
  end

  context "subordinates" do
    before(:all) do
      department = FactoryGirl.create(:department)
      @admin = FactoryGirl.create(:user, :department => department, :role => "admin")
      @valide = (1..2).map {|u| FactoryGirl.create(:absent, :user=> FactoryGirl.create(:user, :department => department, :role => "user")) }
      @invalide = (1..2).map {|u| FactoryGirl.create(:absent, :user=> FactoryGirl.create(:user, :department => nil, :role => "user")) }
    end

    it{ Absent.subordinates(@admin).should include(@valide.first)}
    it{ Absent.subordinates(@admin).should_not include(@invalide) }
  end

end
