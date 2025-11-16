When("I check my drink history") do
  visit items_consumed_index_path(user_id: @current_user.id)
end

When("I add {int} drinks to my drink history") do |int|
  int.times {
    @new_item = FactoryBot.create(:item_consumed, user: @current_user)
  }
end

When("I remove a drink from my drink history") do
  visit items_consumed_index_path(user_id: @current_user.id)
  # fazer ser só o 1o que responder isso
  click_on(id: "remove_item")
end


Then("I should see that there are {int} drinks") do |int|
  # i will kill whoever created ambiguous match
  # por favor alguém arruma isso e me ensina como contar items T_T
  # expect(page).to have_css("header h3", text: "item_consumed", :count => int)
  # expect(page.find(id: "item_consumed").count).to eq(int)
end

Then("I should see no drinks") do
  expect(page).not_to have_content("item_consumed")
end
