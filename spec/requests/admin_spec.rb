#encoding=UTF-8
require 'spec_helper'

describe "Admin" do

  context "admin view", :js => true do
    before(:each) do
      login_admin(:super_admin)
      visit admin_admins_path
    end

    it "admin_view have content" do
      page.should have_content("admin")
      page.should have_content("admin@admin.com")
      page.should have_link("Создать")
      page.should have_link("Просмотр")
      page.should have_link("Редактировать")
      page.should have_link("Удалить")
      page.should have_link("Удаленные")
    end

    it "creating new admin" do
      click_link('creating_new_admin')
      page.should have_content("Добавить администратора")
      within "#new_admin" do
        fill_in 'admin_name', :with => "vasya"
        fill_in 'admin_email', :with => "vasya@qwe.com"
        fill_in 'admin_password', :with => "secret"
        fill_in 'admin_password_confirmation', :with => "secret"
      end
      click_button('Создать')
      page.should have_content("vasya")
      page.should have_content("vasya@qwe.com")
    end
  end
end