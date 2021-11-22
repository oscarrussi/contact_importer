class EditCreateCardName < ActiveRecord::Migration[6.1]
  def change
    rename_column :contacts, :credit_card, :card_number
    rename_column :failed_contacts, :credit_card, :card_number
    remove_column :contacts, :last_card_numbers
    remove_column :failed_contacts, :last_card_numbers
  end
end
