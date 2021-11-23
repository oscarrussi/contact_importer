module ApiHelpers
  def fake_phone_number
    country_code = Faker::PhoneNumber.subscriber_number(length: 2)
    number = []
    2.times { number.push(Faker::PhoneNumber.subscriber_number(length: 3)) }
    2.times { number.push(Faker::PhoneNumber.subscriber_number(length: 2)) }
    "(+#{country_code}) #{number.join(["-", " "].sample)}"
  end

  def serialize_collection(models)
    models.map { |model| ActiveModelSerializers::SerializableResource.new(model) }.to_json
  end

  def serialize_model(model)
    ActiveModelSerializers::SerializableResource.new(model).to_json
  end
end
