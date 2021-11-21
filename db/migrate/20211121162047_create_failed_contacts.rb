class CreateFailedContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :failed_contacts do |t|
      t.string :name
      t.string :birth
      t.string :phone
      t.string :address
      t.string :credit_card
      t.string :last_card_numbers
      t.string :franchise
      t.string :email
      t.references :user, null: false, foreign_key: true
      t.string :errors

      t.timestamps
    end
  end
end
