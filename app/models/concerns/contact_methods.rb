module ContactMethods
  extend ActiveSupport::Concern
  def last_four_digits
    decoded_token = JWT.decode(card_number, Rails.application.credentials[:secret_token], false,
                               { algorithm: 'HS256' })
    "****#{decoded_token[0]['credit_card_number'][-4..]}"
  end
end
