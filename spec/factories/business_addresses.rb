FactoryBot.define do
  factory :business_address do
    business
    street { "Avenida Thomas Edison, 849" }
    city { "Sao Paulo" }
    state { "Sao Paulo" }
    zip { "0140-001" }
    after(:create) do |business_address|
      create(:cardapio, business_address: business_address)
    end
  end
end
