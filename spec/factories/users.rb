FactoryBot.define do
  pass_length = Faker::Number.between(from: 6, to: 128)
  pass = Faker::Alphanumeric.alphanumeric(number: pass_length)
  factory :user do
    email { Faker::Internet.unique.email }
    password { pass }
    password_confirmation { pass }
  end
end
