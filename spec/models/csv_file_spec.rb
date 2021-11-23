require 'rails_helper'

RSpec.describe CsvFile, type: :model do
  subject { FactoryBot.build(:csv_file) }
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_one_attached(:file) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:aasm_state) }
  end

  describe 'methods' do
    it 'check transition from on_hold to processing' do
      subject.aasm.fire!(:process)
      expect(subject.aasm_state).to eq('processing')
    end

    it 'check transition from processing to failed' do
      subject.aasm.fire!(:process)
      subject.aasm.fire!(:fail)
      expect(subject.aasm_state).to eq('failed')
    end

    it 'check transition from on_hold to finished' do
      subject.aasm.fire!(:finish)
      expect(subject.aasm_state).to eq('finished')
    end

    it 'check transition from processing to finished' do
      subject.aasm.fire!(:process)
      subject.aasm.fire!(:finish)
      expect(subject.aasm_state).to eq('finished')
    end
  end
end
