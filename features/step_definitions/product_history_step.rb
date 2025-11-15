Given("that I'm logged in") do
  @current_user = FactoryBot.create(:user)
  sign_in(@current_user)
end

When("I check my drink history") do
  visit items_consumed_user_path(@current_user)
end

When("I add {int} drinks to my drink history") do |int|
  int.times {
    @new_item = FactoryBot.create(:item_consumed, user: @current_user)
  }
end

When("I remove a drink from my drink history") do
  visit items_consumed_user_path(@current_user)
    # fazer ser só o 1o que responder isso
  click_on(id: "remove_item")
end

Then("I should see that there are {int} drink") do |int|
  # i will kill whoever created ambiguous match
  expect(page.find(id: "item_consumed").count).to eq(int)
end
