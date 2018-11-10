FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.word }
    user { create(:user) }
    movie { create(:movie) }
  end
end
