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
      visit rooms_path
    end

    it "room have content" do
      page.should have_content("Vasya Ivanov")
      page.should have_link("Конструктор")
      page.should have_link("Просмотр")
      page.should have_link("Редактировать")
      page.should have_link("Удалить")
    end

    it "room have search form" do
      within "#room_search" do
        fill_in "Введите имя офиса", :with => "1"
        select @user.full_name
      end
      click_button('Найти')
      page.should have_content("Vasya Ivanov")
    end
  end
end
