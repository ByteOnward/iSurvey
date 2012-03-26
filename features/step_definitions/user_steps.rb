Given /^I am on "([^"]*)"$/ do |page_name|
  visit path_to(page_name)
end

Given /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
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

Given /^there are the following users:$/ do |table|
  table.hashes.each do |attrs|
    unconfirmed = attrs.delete("unconfirmed") == "true"
    @user = User.create!(attrs)
    @user.confirm! unless unconfirmed
  end
end

And /^the role of "([^"]*)" is "([^"]*)"$/ do |email, role|
  @user = User.find_by_email (email)
  if  role == "Admin" || role == "Owner"
    Role.create!(:name => role, :group => "admin")
  else
    Role.create!(:name => role, :group => "public")
  end
  @role = Role.find_by_name(role)
  @user.roles << @role
end

When /^I follow "([^"]*)"$/ do |link|
  click_link link
end

Given /^I am signed in as "([^"]*)"$/ do |email|
  @user = User.find_by_email(email)
  visit new_user_session_path
  fill_in "Email", :with => @user[:email]
  fill_in "Password", :with => "password"
  click_button "Sign in"
end

Then /^I should on the "([^"]*)"$/ do |page_name|
  URI.parse(current_url).path.should == path_to(page_name)
end

