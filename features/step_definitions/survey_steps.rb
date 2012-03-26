When /^I select "([^\"]*)" from "([^\"]*)"$/ do |value, field|
  select(value, :from => field)
end

And /^I should be on the project page for "([^"]*)"$/ do |name|
  @survey = Survey.find_by_name(name)
  URI.parse(current_url).path.should == survey_path(@survey)
end

And /^I should have (\d+) survey$/ do |count|
  Survey.count.should == count.to_i
end

Given /^there is a survey called "([^"]*)"$/ do |name|
  @survey = Survey.create!(:name => name, :desc => "What status of the current employee skill sets")
  @question = Question.create(:title => "TestQuestion")
  @survey.questions << @question
  @choice = Choice.create(:content => "TestChoice")
  @question.choices << @choice
end

Then /^I should not see "([^\"]*)"$/ do |text|
  page.should_not have_content(text)
end

And /^the group of "([^"]*)" is "([^"]*)"$/ do |survey, group|
  @survey = Survey.find_by_name(survey)
  @survey.update_attribute(:group, group)
end

When /^the following survey is created:$/ do |table|
  table.hashes.each do |attrs|
    Survey.create!(attrs)
  end
end

Then /^there should have a invite email been sent to "([^"]*)"$/ do |email|
  user = User.find_by_email(email)
  sent = ActionMailer::Base.deliveries.last
  sent.to.should eql([user.email])
end

And /^I fill in new choice with "([^"]*)"$/ do |value|

end

When /^I click "([^"]*)" to delete "([^"]*)"$/ do |arg1, arg2|
#  puts page.body
  puts find('.questions>.group>label>a.delete').inspect
  require "watir-webdriver"
  require "watir-webdriver/extensions/alerts"

  browser = Watir::Browser.new
  browser.goto 'http://localhost:3000/users/login'
  fill_in "Email", :with => "admin@example.com"
  fill_in "Password", :with => "password"
  click_button "Sign in"
  click_link "Edit"
  browser.confirm(true) do
    browser.link(:xpath, '/html/body/div/div[2]/div[1]/div/form/div[2]/div[1]/div/label[1]/a').click
  end


end

