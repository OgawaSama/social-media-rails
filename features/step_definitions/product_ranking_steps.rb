Given("that it has an item worth {int} points") do |int|
  @address = FactoryBot.create(:business_address, business: @business)
  @cardapio = FactoryBot.create(:cardapio, business_address: @address)
  @item = FactoryBot.create(:item_cardapio, cardapio: @cardapio, worth: int)
end

When("I add that item as consumed") do
  @new_item = FactoryBot.create(:item_consumed, user: @current_user, name: @item.nome, brand: @item.cardapio.business_address.business.company_name, worth: @item.worth)
end

When("I check the rankings") do
  visit consumption_ranking_url()
end

Then("I should see myself with {int} points") do |int|
  expect(page).to have_text("#{@current_user.username}")
  expect(page).to have_text("#{int}")
end
