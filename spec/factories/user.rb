FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { '123123' }

    factory :buyer do
      roles { [association(:buyer_role)] }
    end

    factory :seller do
      roles { [association(:seller_role)] }
    end
  end
end
