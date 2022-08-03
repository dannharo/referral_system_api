FactoryBot.define do
  factory :referral do
    referred_by {}
    full_name { Faker::Name.name_with_middle }
    phone_number { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    linkedin_url {}
    cv_url { Faker::Internet.url }
    tech_stack {}
    ta_recruiter {}
    status { 1 }
    comments { Faker::String.random}
    signed_date {}
    active { true }
  end
end