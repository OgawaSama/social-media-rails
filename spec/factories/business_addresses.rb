FactoryBot.define do
  factory :business_address do
    business
    street { "Avenida Thomas Edison, 849" }
    city { "Sao Paulo" }
    state { "Sao Paulo" }
    zip { "0140-001" }
  end
end
