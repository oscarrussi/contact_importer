class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def create
    uploaded_io = params[:file]
    if File.extname(uploaded_io) == '.csv'
      file=save_csv(uploaded_io)
      LoadContactsJob.perform_later(file, current_user.id)
      redirect_to new_contact_path, notice: 'Contacts successfully added'
    else
      redirect_to new_contact_path, alert: 'Only valid format is csv'
    end
  end

  private

  def save_csv(uploaded_io)
    id=CsvFile.create!(file: uploaded_io, filename: uploaded_io.original_filename).id
    CsvFile.find(id)
  end
end