When("I go on the {string} test page") do |id|
  visit main_app.public_send("#{id}_tests_path")
end

When("I click on {string}") do |text|
  all("a, button", text: text).last.click
end

Then("I do not see {string}") do |text|
  expect(page).to have_no_content(text)
end
