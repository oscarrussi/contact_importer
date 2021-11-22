class FailedContact < ApplicationRecord
  include ContactMethods
  attr_accessor :credit_card
  belongs_to :user
  validates_presence_of :error_message
  before_save :credit_card_info

  def credit_card_info
    brand_name = CreditCardDetector::Detector.new(credit_card).brand_name
    self.franchise = brand_name unless brand_name.nil?
    self.card_number = JWT.encode({ credit_card_number: credit_card }, Rails.application.credentials[:secret_token], "HS256")
  end
end
