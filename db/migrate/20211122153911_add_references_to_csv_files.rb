class AddReferencesToCsvFiles < ActiveRecord::Migration[6.1]
  def change
    add_reference :csv_files, :user, null: false, foreign_key: true
  end
end
