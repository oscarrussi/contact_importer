class CreateCsvFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :csv_files do |t|
      t.string :filename
      t.string :aasm_state

      t.timestamps
    end
  end
end
