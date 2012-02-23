Given /^there are the following surveys:$/ do |table|
  table.hashes.each do |hash|
    Factory(:survey, hash)
  end
end

