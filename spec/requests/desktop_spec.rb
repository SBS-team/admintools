#encoding=UTF-8
require 'spec_helper'

describe "Desktop" do
  context "desktop creating", :js => true do
    before(:each) do
      login_admin
      @desktop = FactoryGirl.create(:desktop)
      visit desktops_path
    end

    it "room have content" do
      page.should have_content("Ivanov")
      page.should have_link("Создать")
      page.should have_link("Просмотр")
      page.should have_link("Редактировать")
      page.should have_link("Удалить")
    end

    it "desktop have name office and user name" do
      edit_username_for_desktop
      page.should have_content("Vasya Ivanov")
      page.should have_content("name2")
    end
  end
end


