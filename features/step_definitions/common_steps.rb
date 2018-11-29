When("I go on the {string} test page") do |id|
  visit main_app.public_send("#{id}_tests_path")
end
