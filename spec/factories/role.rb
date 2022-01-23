FactoryBot.define do
  factory :buyer_role, class: 'Role' do
    name { 'buyer' }
  end

  factory :seller_role, class: 'Role' do
    name { 'seller' }
  end
end
