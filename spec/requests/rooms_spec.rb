#encoding=UTF-8
require 'spec_helper'

describe "Rooms" do
  before(:each) do
    @admin = FactoryGirl.create(:admin)
  end

  it "signs me in", :js => true do
    visit new_admin_session_path

    within "#new_admin" do
      fill_in 'Name', :with => @admin.name
      fill_in 'Password', :with => "secret"
    end
    click_button('Sign in')
    visit(root_path)
    page.should have_content("Signed in as #{@admin.name}")
  end
#context "riidfd", :js => true do
  #  before(:each) do
  #    room_creating
  #  end
  #  it "room have content" do
  #    visit rooms_path
  #    page.should have_content("1")
  #    page.should have_content("Vasya Ivanov")
  #  end
  #end
end
