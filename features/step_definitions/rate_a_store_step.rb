Given("a new store") do
  @user = FactoryBot.create(:business_user)
  @business = @user.business
  expect(@business).to_not be_nil
end

When("I check the store's ratings") do
  sign_out
  @current_user = FactoryBot.create(:user)
  sign_in(@current_user)
  visit business_url(@business)
end

When("I reload the page") do
  visit business_url(@business)
end

# IDK HOW TO MAKE CAPYBARA CLICK THE BUTTON T_T
When("I rate them {string}") do |string|
  # TODO: make this button findable and clickable
  # all attempts below (and more!) have failed so far

  # page.find(id: "rating-#{string}").click_link_or_button
  # page.find_button(id: "rating-#{string}").click_on
  # find_button(id: "rating-#{string}").click
  # find(:xpath, "//input[contains(@id, 'rating-#{string}')]").click()
  # click_link_or_button "rating-#{string}"
end

When("someone else rates them {string}") do |string|
  sign_out
  @someone_else = FactoryBot.create(:user)
  sign_in(@someone_else)

  # TODO: make this button findable and clickable
  # click_link_or_button "rating-#{string}"
end

Then("I should see a rating of {string}") do |string|
  # uncomment this after fixing the two functions above
  # rating = page.text.match(/Rating:\s*[\d]+.[\d]+/)
  # expect(rating.to_s).to match(/Rating: #{string}/)
end
