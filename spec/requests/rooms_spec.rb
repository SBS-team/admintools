#encoding=UTF-8
require 'spec_helper'

describe "Rooms" do
  before(:each) do
    login_admin
  end

  it "signs me in", :js => true do
    visit(root_path)
    page.should have_content("Signed in as #{@admin.name}")
  end
  context "room creating", :js => true do
    before(:each) do
      user_creating
    end
    it "room have content" do
      visit users_path
      page.should have_content("Vasya Ivanov")
    end
  end
end
