When /^I view the homepage$/ do
  visit root_path
end

Then /^I should be able to read about the application$/ do
  page.should have_css('[data-role=description]')
end

Then /^I should be able to sign in or sign up$/ do
  page.should have_css("a[href='/sign_in']")
  page.should have_css("a[href='/sign_up']")
end
