#encoding=UTF-8
require 'spec_helper'

describe "Admin" do  #, :js => true
  context "admin view" do
    before(:each) do
      login_admin(:super_admin)
      (1..5).each {|i| FactoryGirl.create(:admin, :name => "name#{i}", :email => "email#{i}@blabla.com")}
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
  end

  describe "admin search" do
    before(:each) do
      login_admin(:super_admin)
      (1..5).each {|i| FactoryGirl.create(:admin, :name => "name#{i}", :email => "email#{i}@blabla.com")}
      visit admin_admins_path
    end

    it "search admin name" do
      page.should have_content("blabla")
    end

    it "search admin name" do
      within "#admin_search" do
        fill_in 'search_name_equals', :with => "name2"
      end
      click_button('Найти')
      page.should have_content("name2")
      page.should have_content("email2@blabla.com")
      page.should_not have_content("email3@blabla.com")
    end

    it "search admin email" do
      within "#admin_search" do
        fill_in 'search_email_equals', :with => "email3@blabla.com"
      end
      click_button('Найти')
      page.should have_content("name3")
      page.should have_content("email3@blabla.com")
      page.should_not have_content("email4@blabla.com")
    end

    it "search admin abort" do
      within "#admin_search" do
        fill_in 'search_name_equals', :with => "name3"
        fill_in 'search_email_equals', :with => "email3@blabla.com"
      end
      click_link('Сбросить')
      page.should have_content("email3@blabla.com")
      page.should have_content("email4@blabla.com")
    end
  end

  describe "Managing аdmins" do
    before(:each) do
      login_admin(:super_admin)
      visit admin_admins_path
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

    #it "destroy to admin"

    it "show admin" do
      click_link("Просмотр")
      page.should have_content("Информация пользователя")
    end

    it "update to admin" do
      click_link("Редактировать")
      page.should have_content("Изменить пользователя")
    end
  end
end