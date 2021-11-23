require 'rails_helper'

RSpec.describe FailedContact, type: :model do
  subject { FactoryBot.build(:failed_contact) }
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:error_message) }
  end

  describe 'methods' do
    it "when valid credit card" do
      random_card = cards.sample
      contact = FactoryBot.create(:failed_contact, credit_card: random_card)
      expect(contact.last_four_digits).to eq("****"+random_card[-4..-1])
    end

    it "when invalid credit card" do
      contact = FactoryBot.create(:failed_contact, credit_card: Faker::Number.between(from: 100, to: 999).to_s)
      expect(contact.last_four_digits).to eq("****")
    end
  end
end