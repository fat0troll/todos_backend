FactoryBot.define do
  factory :task do
    name { Faker::Overwatch.hero }
    done false
    todo_id { Faker::Number.number(10) }
  end
end