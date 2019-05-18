FactoryBot.define do
  factory :user do
    login { Faker::Internet.email }
    password { Faker::Lorem.characters(20) }
  end
end
