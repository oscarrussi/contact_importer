FactoryBot.define do
  factory :csv_file do
    user_id { FactoryBot.create(:user).id }
    filename { Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample) }
  end
end
