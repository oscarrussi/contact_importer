FactoryBot.define do
  factory :user do
    name { Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample)  }
    birth {Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample) }
    email { Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample)  }
    phone { Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample)  }
    address {	Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample)}
    credit_card { Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample)  }
    user_id { FactoryBot.create(:author).id }
    error { Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample) }
  end
end