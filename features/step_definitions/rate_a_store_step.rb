Given("a new store") do
  @user = FactoryBot.create(:business_user)
  @business = @user.business
  expect(@business).to_not be_nil
end

# IDK HOW TO MAKE CAPYBARA LOGIN THE USER T_T
# this is giving "BCrypt:Errors:InvalidHash" for the password, but we don't even use Bcrypt???

When("I check the store's ratings") do
  @current_user = FactoryBot.create(:user)
  # login_as @current_user
  sign_in(@current_user)
  visit business_url(@business)
end

# IDK HOW TO MAKE CAPYBARA CLICK THE BUTTON T_T

When("I rate them {string}") do |string|
  click_link_or_button "rating-#{string}"
end

When("someone else rates them {string}") do |string|
  @someone_else = FactoryBot.create(:user)
  # login_as @someone_else
  sign_in(@someone_else)
  click_link_or_button "rating-#{string}"
end

Then("I should see a rating of {string}") do |string|
  rating = page.text.match(/Rating:\s*[\d]+/)
  expect(rating).to eq("Rating: #{string}")
end

