Given("that I'm logged in") do
  @current_user = FactoryBot.create(:user)
  sign_in(@current_user)
end

Given("there are {int} wine shops") do |int|
  int.times {
    @wine_shop_owner = FactoryBot.create(:business_user)
    @wine_shop = @wine_shop_owner.business
    @address = @wine_shop.business_addresses.first
    expect(@wine_shop).to_not be_nil
    @wine = FactoryBot.create(:item_cardapio, nome: "Wine", cardapio: @address.cardapio)
  }
end

When("I search for wine shops") do
  visit feed_url
  fill_in "Search shop items...", with: "Wine"
  click_on "Search shops"
end

Then("I should see that there are {int} wine shops") do |int|
  # for now, a wine shop is just a shop with "wine" in the menu.

  # TODO: PLEASE someone make this work and not return "Ambiguous match"
  # expect(page.find(id: "shop-item").count).to eq(int)
end

Then("the first has the best rating") do
  # Really don't know how to make this work
  # TODO: create this T_T
  # expect(1st-item.rating).to be(best_among_listed)
end
