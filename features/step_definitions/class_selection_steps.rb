Given /^I visit the courses page$/ do
  visit courses_path	
  # assert (not Course.all.empty?), "No classes found at all"
end

When /^I select a course$/ do
  click_button "CSCI Course"
end

And /^I have the required prerequisite$/ do
	assert Course.find_by_id(id).valid?, "Post ##{ id } was not found at all"
end

Then /^the course should disappear$/ do
	page.should have_selector('#course', visible: false)
end

And /^I should see the course posted$/ do
  post = Course.find_by_id id
end




# Given /^I visit the courses page$/ do
#   visit courses_path
#   # assert (not Course.all.empty?), "No classes found at all"
# end

# When /^I select a course$/ do
#   click_button "CSCI Course"
# end

And /^I dont have the required prerequisite$/ do
	assert Course.find_by_id(id).valid?
end

Then /^I should see an error message$/ do
  expect(page).to have_selector('div.alert.alert-error')
end