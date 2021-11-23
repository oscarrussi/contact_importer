module ApiHelpers
  def fake_phone_number
    country_code = Faker::PhoneNumber.subscriber_number(length: 2)
    number = []
    2.times { number.push(Faker::PhoneNumber.subscriber_number(length: 3)) }
    2.times { number.push(Faker::PhoneNumber.subscriber_number(length: 2)) }
    "(+#{country_code}) #{number.join(['-', ' '].sample)}"
  end

  def cards
    %w[371449635398431 30569309025904 6011111111111117 3530111333300000 5555555555554444
       4111111111111111]
  end
end
