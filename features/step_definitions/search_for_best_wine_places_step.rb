Given("that I'm logged in") do
  @current_user = FactoryBot.create(:user, username: "my name", email: "test@example.com", password: "password123", password_confirmation: "password123")

  # Fazer login via Devise
  visit new_user_session_path
  fill_in "Email", with: @current_user.email
  fill_in "Password", with: "password123"
  click_button "Log in"

  expect(page).to have_content("Signed in successfully")
end

Given("there are {int} wine shops") do |count|
  count.times do |i|
    # Criar business diretamente como store (loja)
    business = FactoryBot.create(:business,
      company_name: "Wine Shop #{i + 1}",
      business_type: "store",
      rating: 5.0 - i * 0.5  # Primeira loja tem rating 5.0, segunda 4.5, etc.
    )

    # Criar endereço
    address = FactoryBot.create(:business_address, business: business)

    # Criar cardápio
    cardapio = FactoryBot.create(:cardapio, business_address: address, titulo: "Cardápio de Vinhos")

    # Criar item de cardápio com "wine" no nome
    FactoryBot.create(:item_cardapio,
      nome: "Vinho Tinto Premium #{i + 1}",
      cardapio: cardapio,
      descricao: "Excelente vinho para degustação",
      preco: 89.90,
      tipo: 1  # bebida
    )
  end
end

When("I search for wine shops") do
  # Usar a nova funcionalidade de busca de bares/lojas
  visit feed_path

  # Preencher o campo de busca
  fill_in "search_bars_query", with: "Wine"
  click_button "Search bars"
end

Then("I should see that there are {int} wine shops") do |expected_count|
  # Aguardar a página carregar
  expect(page).to have_content("Resultados para")

  # Estratégia 1: Contar elementos que contenham "Wine Shop"
  wine_shop_count = page.all('div', text: /Wine Shop/i).count

  # Estratégia 2: Se não encontrar elementos específicos, contar ocorrências no texto
  if wine_shop_count == 0
    wine_shop_count = page.body.scan(/Wine Shop/i).count
  end

  # Estratégia 3: Verificar se há elementos de business list
  business_elements = page.all('.business-list, [class*="business"], .bg-white')
  if business_elements.any?
    wine_shop_count = business_elements.select { |el| el.text =~ /Wine Shop/i }.count
  end

  expect(wine_shop_count).to eq(expected_count),
    "Expected to find #{expected_count} wine shops, but found #{wine_shop_count}. Page content: #{page.text}"
end

Then("the first has the best rating") do
  # Verificar se a primeira wine shop tem rating 5.0
  expect(page).to have_content("Wine Shop 1")

  # Procurar por elementos que contenham o rating 5.0 perto de "Wine Shop 1"
  first_wine_shop_section = page.find('div', text: /Wine Shop 1/i)
  expect(first_wine_shop_section).to have_content('5.0')
end

Given("there are no wine shops") do
  # Não fazer nada - garantir que não há wine shops criados
  Business.where("company_name LIKE ?", "%Wine Shop%").destroy_all
  ItemCardapio.where("nome LIKE ?", "%Vinho%").destroy_all
end

Then("I should see that there are {int} wine shops") do |expected_count|
  if expected_count == 0
    expect(page).to have_content("Nenhum bar ou loja encontrado")
  else
    # Aguardar a página carregar
    expect(page).to have_content("Resultados para")

    # Tentar diferentes estratégias para contar wine shops
    wine_shop_count = 0

    # Estratégia 1: Buscar por elementos que contenham "Wine Shop"
    wine_shop_elements = page.all('div, li, article', text: /Wine Shop/i)
    wine_shop_count = wine_shop_elements.count

    # Estratégia 2: Se não encontrar, contar ocorrências no texto da página
    if wine_shop_count == 0
      wine_shop_count = page.text.scan(/Wine Shop/i).count
    end

    # Estratégia 3: Verificar elementos de business
    business_elements = page.all('[class*="business"], .bg-white, .shadow')
    if business_elements.any?
      wine_shop_count = business_elements.count
    end

    expect(wine_shop_count).to eq(expected_count),
      "Expected #{expected_count} wine shops but found #{wine_shop_count}. Page: #{page.text[0..500]}"
  end
end
