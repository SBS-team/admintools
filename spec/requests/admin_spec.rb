#encoding=UTF-8
require 'spec_helper'

describe "Admin" do
  before(:each) do
    login_admin
  end

  context "admin view", :js => true do
    before(:each) do
      visit admin_admins_path
    end

    it "admin_view have content" do
      page.should have_content("admin1")
      page.should have_content("example1@example.com")
      page.should have_link("Создать")
      page.should have_link("Просмотр")
      page.should have_link("Редактировать")
      page.should have_link("Удалить")
      page.should have_link("Удаленные")
    end

    it "creating new admin" do
      click_link("Создать")
      page.should_not have_content("Добавить администратора")
    end
  end
end
