# Each friend has 5 points more than the last
Given("{int} friends with points") do |friends|
  # Item creation
  owner = FactoryBot.create(:business_user, username: "dono")
  business = FactoryBot.create(:business, user: owner)
  address = FactoryBot.create(:business_address, business: business)
  cardapio = FactoryBot.create(:cardapio, business_address: address)
  item = FactoryBot.create(:item_cardapio, cardapio: cardapio, worth: 5)

  friends.times do |i|
    i = i+1
    friend = FactoryBot.create(:user, username: "user_#{i}")
    i.times do |j|
      item = FactoryBot.create(:item_consumed, user: friend, date: Date.today, worth: 5)
    end
  end
end

Given("that I have {int}*five points {string}") do |int, date|
  if date == "today"
    date = Date.today
  elsif date == "yesterday"
    date = Date.yesterday
  else
    date = Date.tomorrow
  end
  new_item = FactoryBot.create(:item_consumed, user: @current_user, worth: int*5, date: date)
end

When("I check my friends rankings") do
  visit friends_ranking_url(start_date: "", end_date: "")
end

When("I select {string}") do |option|
  click_link(option)
end

Then("I should see that I'm number {int} among {int}") do |position, quantity|
  expect(page).to have_text("#{position} -- #{@current_user.username}")
  quantity = quantity - 1
  quantity.times do |i|
    expect(page).to have_text("user_#{i+1}")
  end
end

Then("I should see that I'm not there among {int} friends") do |quantity|
  quantity = quantity
  quantity.times do |i|
    expect(page).to have_text("user_#{i+1}")
  end
  expect(page).not_to have_text("-- #{@current_user.username}")
end
