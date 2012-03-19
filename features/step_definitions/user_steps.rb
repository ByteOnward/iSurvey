Given /^I am not logged in$/ do
  #visit 
end

Given /^I am on "([^"]*)"$/ do |page_name|
  visit path_to(page_name)
end

Given /^I fill "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in field, :with => value
end

Given /^I press "([^"]*)"$/ do |button|
  click_button button
end

Then /^I should see "([^"]*)"$/ do |msg|
  page.should have_content(msg)
end

Then /^there should have a active email been sent to "([^"]*)"$/ do |email|
  user = User.find_by_email(email)
  sent = ActionMailer::Base.deliveries.last
  sent.to.should eql([user.email])
end

