class CsvFile < ApplicationRecord
  include AASM
  has_one_attached :file
  validates :aasm_state, presence: true

  aasm do # default column: aasm_state
    state :on_hold, initial: true
    state :processing
    state :failed
    state :finished

    event :process do
      transitions from: :on_hold, to: :processing
    end

    event :fail do
      transitions from: :processing, to: :failed
    end

    event :finish do
      transitions from: ["on_hold", "processing"], to: :finished
    end
  end
end
