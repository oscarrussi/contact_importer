class ChangeAgainAasmDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :csv_files, :aasm_state, "on_hold"
  end
end
