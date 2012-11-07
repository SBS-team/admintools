# encoding: UTF-8
Given /^the following (.+) records exist:?$/ do |factory, table|
  table.hashes.each do |hash|
    FactoryGirl.create(factory, hash)
  end
end

When /^I go to on ([^\"]*) page$/ do |url|
  path_to(url)
end

When /^I click on the ([^\"]*) button$/ do |url|
  path_to(url)
end

When /^I click on the ([^\"]*) button to create a user$/ do |url|
  path_to(url)
end

Given /^I am logged in as "([^\"]*)" with password "([^\"]*)"$/ do |login, password|
  fill_in 'admin_name', :with => login
  fill_in 'admin_password', :with => password
  click_button "Sign in"
end

Then /^I should see "([^\"]*)"$/ do |text|
  page.should have_content(text)
end

Given /^I create a new user with fields "([^\"]*)"$/ do |fields|
    fill_in 'user_first_name', :with => elem(fields)[0]
    fill_in 'user_last_name', :with => elem(fields)[1]
    fill_in 'user_email', :with => elem(fields)[2]
    fill_in 'user_skype', :with => elem(fields)[3]
  click_button "Создать"
end

def elem(obj)
  obj.split(', ')
end
