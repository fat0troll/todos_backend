FactoryBot.define do
  factory :todo do
    title { Faker::Lorem.word }
    user_id { Faker::Number.number(10) }
    is_public false
  end
end