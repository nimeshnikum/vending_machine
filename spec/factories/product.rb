FactoryBot.define do
  factory :product do
    seller
    sequence(:name) { |n| "product#{n}" }
    quantity { 10 }
    cost { 15 }
  end
end
