FactoryBot.define do
  factory :failed_contact do
    name { Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample) }
    birth { Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample) }
    email { Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample) }
    phone { Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample) }
    address {	Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample) }
    credit_card { Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample) }
    user_id { FactoryBot.create(:user).id }
    error_message { Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample) }
  end
end
