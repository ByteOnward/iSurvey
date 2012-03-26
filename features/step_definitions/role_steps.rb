When /^I visit ManageUsers page$/ do
  visit '/roles/users'
end

And /^there is role of "([^"]*)"$/ do |role|
  if role == "Admin" || role == "Owner"
    Role.create!(:name => role, :group => "admin")
  else
    Role.create!(:name => role, :group => "public")
  end
end

When /^I grant "([^"]*)" to "([^"]*)"$/ do |role, email|
  @user = User.find_by_email (email)
  @role = Role.find_by_name(role)
  @user.roles << @role
end

Then /^the role of "([^"]*)" should be "([^"]*)"$/ do |email, role|
  @user = User.find_by_email (email)
  @role = Role.find_by_name (role)
  @user.roles.last.should  == @role
end