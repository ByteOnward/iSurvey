Given /^I fill in "([^"]*)" with empty$/ do |field|
  fill_in field, :with => nil
end

Given /^I click "([^"]*)"$/ do |button|
  if button == "Delete" || button == "Sign out"
    click_link button
  else
    click_button button
  end
  page.driver.browser.switch_to.alert.accept
  #page.evaluate_script('window.confirm = function() { return true; }')
end

When /^I select "([^\"]*)" from "([^\"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^I click New Survey button$/ do
  find('.title_bar > input').click
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
  sent = Notifier.deliveries.last
  sent.to.should eql([user.email])
end

And /^I fill in new choice with "([^"]*)"$/ do |value|
  question = find(".survey > .questions")
  choices =  question.all('.choices>div>span.group>textarea')
  choices[1].set(value)
end

When /^I click X to delete "([^"]*)"$/ do |content|
  if content == "TestQuestion"
    find('.questions>.group>label>a.delete').click
  elsif content == "TestChoice"
    find('.questions>.group>.choices label>a.delete').click
  end
  page.driver.browser.switch_to.alert.accept
end

And /^I fill in new question with "([^"]*)"$/ do |text|
  questions = all('.survey > .questions > .group > textarea')
  questions[1].set(text)
end

And /^I fill in choice of "([^"]*)"with "([^"]*)"$/ do |content, value|
  questions = all('.survey > .questions > .group')
  question = questions.last
  choices = question.all('.choices>div>span.group>textarea')
  choices[0].set(value)
end

When /^I choose "([^\"]*)"$/ do |field|
  find('.survey > .survey_body > .question > .question_body > .question_item > input').set(true)
end

And /^I should be on the result page for "([^"]*)"$/ do |name|
  URI.parse(current_url).path.should == '/surveys/1/stats'
end