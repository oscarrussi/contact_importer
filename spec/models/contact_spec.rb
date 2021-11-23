require 'rails_helper'
RSpec.describe Contact, type: :model do
  subject { FactoryBot.build(:contact) }
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    context 'name' do
      it { should validate_presence_of(:name) }
      it {
        should_not allow_value('p@$$w0rd').for(:name)
          .with_message('only alphanumeric or minus symbol are allowed')
      }
      it { should allow_value("#{Faker::Alphanumeric.alphanumeric(number: (1..30).to_a.sample)}-").for(:name) }
    end

    context 'phone' do
      it { should validate_presence_of(:phone) }
      it {
        should_not allow_value('3223352127').for(:phone)
          .with_message('invalid phone format')
      }
      it { should allow_value('(+57) 322 335 21 26').for(:phone) }
      it { should allow_value('(+57) 322-335-21-26').for(:phone) }
    end

    context 'address' do
      it { should validate_presence_of(:address) }
    end

    context 'email' do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).scoped_to(:user_id) }
      it {
        should_not allow_value('a@a').for(:email)
          .with_message('invalid email format')
      }
      it { should allow_value(Faker::Internet.email).for(:email) }
    end

    context 'user_id' do
      it { should validate_presence_of(:user_id) }
    end

    context 'credit_card' do
      it 'accept valid credit card' do
        contact = FactoryBot.create(:contact, credit_card: cards.sample)
        expect(contact.valid?).to eq(true)
      end

      it 'reject invalid credit card' do
        contact = FactoryBot.build(:contact, credit_card: '111111')
        contact.valid?
        expect(contact.errors.messages[:credit_card][0]).to eq('invalid credit card number')
      end
    end

    context 'date_of_birth' do
      it 'accept valid %Y%m%d format' do
        contact = FactoryBot.build(:contact, date_of_birth: '2010-05-15')
        expect(contact.valid?).to eq(true)
      end

      it 'accept valid %F format' do
        contact = FactoryBot.build(:contact, date_of_birth: '20100515')
        expect(contact.valid?).to eq(true)
      end

      it 'reject invalid date_of_birth' do
        contact = FactoryBot.build(:contact, date_of_birth: '2010.05.15')
        contact.valid?
        expect(contact.errors.messages[:date_of_birth][0]).to eq('Should use ISO 8601 (%Y%m%d or %F) format')
      end
    end
  end

  describe 'methods' do
    context 'last_four_digits' do
      describe 'methods' do
        it 'when valid credit card' do
          random_card = cards.sample
          contact = FactoryBot.create(:failed_contact, credit_card: random_card)
          expect(contact.last_four_digits).to eq("****#{random_card[-4..]}")
        end

        it 'when invalid credit card' do
          contact = FactoryBot.build(:failed_contact, credit_card: Faker::Number.between(from: 100, to: 999).to_s)
          expect { contact.last_four_digits }.to raise_error(JWT::DecodeError)
        end
      end
    end
    context 'birth_human_date_format' do
      subject { FactoryBot.create(:contact, date_of_birth: '1991-01-21').birth_human_date_format }
      it { should eq('1991 January 21') }
    end
  end
end
