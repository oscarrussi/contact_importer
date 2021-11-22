class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @contacts = pagy(Contact.where(user_id: current_user.id))
  end

  def create
    uploaded_io = params[:file]
    if File.extname(uploaded_io) == ".csv"
      file = save_csv(uploaded_io)
      LoadContactsJob.perform_later(file, current_user.id)
      redirect_to new_contact_path, notice: "Contacts successfully added"
    else
      redirect_to new_contact_path, alert: "Only valid format is csv"
    end
  end

  private

  def save_csv(uploaded_io)
    id = CsvFile.create!(file: uploaded_io, filename: uploaded_io.original_filename, user_id: current_user.id).id
    CsvFile.find(id)
  end
end
