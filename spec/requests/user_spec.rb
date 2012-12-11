#encoding=UTF-8
require 'spec_helper'

describe "User" do
  before(:each) do
    login_admin
    @user = FactoryGirl.create(:user)
  end

  context "user creating", :js => true do
    before(:each) do
      visit admin_users_path
    end

    it "user_view have content" do
      page.should have_content("Vasya Ivanov")
      page.should have_content("foo1@example.com")
      page.should have_content("fooskype1")
      page.should have_content("Пусто")
      page.should have_link("Создать")
      page.should have_link("Профиль")
      page.should have_link("Редактировать")
      page.should have_link("Уволить")
      page.should have_link("Уволенные")
    end

    it "user_view_show have content" do
      click_link('user_profile')
      page.should have_content("Vasya Ivanov")
      page.should have_content( "foo2@example.com")
      page.should have_content( "fooskype2")
      page.should have_content( "info2")
    end
  end
end
