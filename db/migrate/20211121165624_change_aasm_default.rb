class ChangeAasmDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :csv_files, :aasm_state, "On Hold"
  end
end
