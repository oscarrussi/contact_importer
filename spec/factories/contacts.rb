require_relative '../support/api_helpers'

module ApiHelpersMethods
  extend ApiHelpers
end
FactoryBot.define do
  factory :contact do
    name { Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample) }
    date_of_birth { Faker::Date.between(from: '1000-01-01', to: '2021-09-23').to_s }
    email { Faker::Internet.unique.email }
    phone { ApiHelpersMethods.fake_phone_number }
    address {	Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample) }
    credit_card { CreditCardValidations::Factory.random }
    user_id { FactoryBot.create(:user).id }
  end
end
