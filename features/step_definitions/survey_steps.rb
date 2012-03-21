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