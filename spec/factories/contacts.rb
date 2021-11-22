FactoryBot.define do
  country_code = Faker::PhoneNumber.subscriber_number(length: 2)
  number=[]
  2.times {number << Faker::PhoneNumber.subscriber_number(length: 3)}
  2.times {number << Faker::PhoneNumber.subscriber_number(length: 2)}
  phone_number = "(+#{country_code}) #{number.join(["-", " "].sample)}"
  factory :user do
    name { Faker::Name.name }
    date_of_birth {Faker::Date.between(from: '1000-01-01', to: '2021-09-23')}
    email { Faker::Internet.unique.email }
    phone { phone_number }
    address {	Faker::Alphanumeric.alphanumeric(number: 10)}
    credit_card { CreditCardValidations::Factory.random }
    user_id { FactoryBot.create(:author).id }
  end
end
