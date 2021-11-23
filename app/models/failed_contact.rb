class FailedContact < ApplicationRecord
  include ContactMethods
  attr_accessor :credit_card
  belongs_to :user
  validates_presence_of :user_id
  validates_presence_of :error_message
  before_save :credit_card_info

  def credit_card_info
    detector = CreditCardDetector::Detector.new(credit_card)
    brand_name = detector.brand.nil? ? detector.brand_name : detector.brand.id
    self.franchise = brand_name unless brand_name.nil?
    self.card_number = JWT.encode({ credit_card_number: credit_card.nil? ? "" : credit_card }, Rails.application.credentials[:secret_token], "HS256")
  end
end
