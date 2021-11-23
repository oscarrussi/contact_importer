class Contact < ApplicationRecord
  include ContactMethods
  attr_accessor :credit_card, :date_of_birth
  belongs_to :user
  validates :email, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                      message: "invalid email format" }
  validates :name, format: { with: /\A[a-zA-Z0-9\- ]+\z/,
                            message: "only alphanumeric or minus symbol are allowed" }
  validate :iso_8601_date_format
  validates :phone, format: { with: /\A\(\+[0-9]{2}\)(( [0-9]{3}){2}( [0-9]{2}){2}| ([0-9]{3}\-){2}[0-9]{2}\-[0-9]{2})\z/,
                     message: "invalid phone format" }
  validate :valid_card_number
  validates :email, uniqueness: { scope: :user_id }
  validates_presence_of :name, :phone, :address, :email, :user_id

  def birth_human_date_format
    self.birth.stamp("1999 March 1")  
  end

  private

  def iso_8601_date_format
    if date_format("%Y%m%d") || date_format("%F")
      self.birth = date_of_birth
    else
      self.errors.add(:date_of_birth, message: "Should use ISO 8601 (%Y%m%d or %F) format")
    end
  end

  def date_format(format_)
    begin
      DateTime.strptime(date_of_birth, format_)
      return true
    rescue => exception
      return false
    end
  end

  def valid_card_number
    detector = CreditCardDetector::Detector.new(credit_card)
    brand_name = detector.brand.nil? ? detector.brand_name : detector.brand.id
    if brand_name.nil?
      self.errors.add(:credit_card, message: "invalid credit card number")
    else
      self.franchise = brand_name
      self.card_number = JWT.encode({ credit_card_number: credit_card }, Rails.application.credentials[:secret_token], "HS256")
    end
  end
end
