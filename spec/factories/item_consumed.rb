FactoryBot.define do
  factory :item_consumed do
    user
    sequence(:name) { |n| "item #{n}" }
    quantity { 1 }
    item_type { :Beer }
    brand { "杭州千岛湖啤酒有限公司" }
    date { 2.days.ago }
  end
end
