class LoadContactsJob < ApplicationJob
  queue_as :default

  def perform(file, user_id)
    @any_success=false
    CSV.parse(file.file.download, headers: true) do |row|
      file.aasm.fire!(:process) if file.aasm_state == "on_hold"
      contact_from_csv(row, user_id)
    end
    if file.aasm_state == "on_hold" || @any_success
      file.aasm.fire!(:finish) 
    else
      file.aasm.fire!(:fail) 
    end
    puts "contacts successfully updated"
  rescue StandardError => e
    puts e.message
  end

  private

  def contact_from_csv(row, user_id)
    contact = Contact.new(name: row["name"], date_of_birth: row["date_of_birth"], phone: row["phone"], address: row["address"], credit_card: row["credit_card"], email: row["email"], user_id: user_id)
    if contact.valid?
      contact.save
      @any_success=true
      return
    end
    failed=FailedContact.new(name: row["name"], birth: row["date_of_birth"], phone: row["phone"], address: row["address"], credit_card: row["credit_card"], email: row["email"], user_id: user_id, error_message: contact.errors.messages)
    failed.save
  end
end
