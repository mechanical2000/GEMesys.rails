Then("I see {string} out of modal") do |text|
  expect(page).to have_no_selector("#modal")
  expect(page).to have_content(text)
end

Then("I see {string} in modal") do |text|
  expect(find("#modal")).to have_content(text)
end
