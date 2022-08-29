FactoryBot.define do
  factory :role do
    trait :role_admin do
      name { 'admin' }
    end

    trait :role_user do
      name { 'user' }
    end

    trait :role_ta do
      name { 'ta' }
    end
  end
end
