#encoding=UTF-8
require 'spec_helper'

describe "Rooms" do
  before(:each) do
    login_admin
  end

  it "room have content", :js => true do
    #sleep(100)
    #visit root_path
    page.should have_content("Signed in as #{@admin.name}")
    #page.should have_content("Компьютеры")
    #page.should have_content("Пользователи")
    #page.should have_content("Устройства")
    #page.should have_content("Календарь")
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
