#encoding=UTF-8
require 'spec_helper'

describe "Device" do
  before(:each) do
    login_admin
    @user = FactoryGirl.create(:user)
    @device = FactoryGirl.create(:device)
  end

  context "device creating", :js => true do
    before(:each) do
      visit devices_path
    end

    it "user_view have content" do
      page.should have_content("Vasya Ivanov")
      page.should have_content("name1")
      page.should have_link("Создать")
      page.should have_link("Просмотр")
      page.should have_link("Редактировать")
      page.should have_link("Удалить")
    end
  end
end
