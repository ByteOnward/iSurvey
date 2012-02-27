Given /^there are the following users:$/ do |table|
  table.hashes.each do |hash|
    Factory(:role, hash)
  end
end

Given /^I am signed in as "([^"]*)" with password "([^"]*)"$/ do |email, password|
  visit new_user_session_path
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "Sign in"
end

Given /^I am on "([^"]*)"$/ do |page_name|
  visit path_to(page_name)
end

When /^I follow "([^"]*)"$/ do |link|
  click_link link
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in field, :with => value
end

When /^I press "([^"]*)"$/ do |button|
  click_button button
end

Then /^I should see "([^"]*)"$/ do |msg|
  page.should have_content(msg)
end

Then /^I should have (\d+) survey$/ do |count|
  Survey.count.should == count.to_i
end

Then /^I should on "([^"]*)"$/ do |page_name|
  URI.parse(current_url).path.should == path_to(page_name)
end

