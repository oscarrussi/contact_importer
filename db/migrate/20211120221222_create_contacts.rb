class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.datetime :birth
      t.string :phone
      t.string :address
      t.string :credit_card
      t.integer :last_card_numbers
      t.string :franchise
      t.string :email

      t.timestamps
    end
  end
end
