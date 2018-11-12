FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Internet.user_name }
    password { Faker::Internet.password(8) }
    confirmed_at { Time.now }
  end
end
