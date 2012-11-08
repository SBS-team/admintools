# encoding: UTF-8
Given /^the following (.+) records exist:?$/ do |factory, table|
  table.hashes.each do |hash|
    FactoryGirl.create(factory, hash)
  end
end

Given /^I am logged in as "([^\"]*)" with password "([^\"]*)"$/ do |login, password|
  fill_in 'admin_name', :with => login
  fill_in 'admin_password', :with => password
  click_button "Sign in"
end

Given /^I create a new user with fields "([^\"]*)"$/ do |fields|
  fill_in 'user_first_name', :with => elem(fields, ', ')[0]
  fill_in 'user_last_name', :with => elem(fields, ', ')[1]
  fill_in 'user_email', :with => elem(fields, ', ')[2]
  fill_in 'user_skype', :with => elem(fields, ', ')[3]
  click_button "Создать"
end

Given /^I create a new room "([^\"]*)" and select user "([^\"]*)"$/ do |room_name, full_name|
  fill_in 'room_name', :with => room_name
  select(full_name, :from => "user_id")
  click_button "Создать"
end

Given /I create a new desktop "([^\"]*)" and select user "([^\"]*)" and room "([^\"]*)"$/ do |fields, full_name, room_name|
  fill_in 'desktop_name', :with => elem(fields, ', ')[0]
  fill_in 'desktop_ip', :with => elem(fields, ', ')[1]
  fill_in 'desktop_mac', :with => elem(fields, ', ')[2]
  select(full_name, :from => "user_id")
  select(room_name, :from => "room_id")
  click_button "Создать"
end

When /^I go to on ([^\"]*) page$/ do |url|
  path_to(url)
end

When /^I click on the ([^\"]*)$/ do |url|
  path_to(url)
end

Then /^I should see "([^\"]*)"$/ do |texts|
  elem(texts, ' & ').each do |text|
    page.should have_content(text)
  end
end

Then /^I should see flash message "([^\"]*)"$/ do |text|
  page.should have_selector('div', :class => "alert fade in alert-success") do |flash|
    flash.should have_content(:text => text)
  end
end