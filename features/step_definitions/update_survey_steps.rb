When /^I fill in new "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

