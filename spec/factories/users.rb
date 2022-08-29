FactoryBot.define do
  factory :user do
    association :user, factory: :role

    trait :admin do
      name { Faker::Name.name_with_middle }
      email { Faker::Internet.email }
      role_id {}
      active { Faker::Boolean.boolean }
    end

  end
end
