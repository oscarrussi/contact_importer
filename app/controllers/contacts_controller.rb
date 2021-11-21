class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def create
    uploaded_io = params[:file]
    if File.extname(uploaded_io) == '.csv'
      SaveCsv.call(uploaded_io)
      LoadBooksJob.perform_later
      redirect_to admin_update_books_path, notice: 'Contacts successfully added'
    else
      redirect_to admin_update_books_path, alert: 'Only valid format is csv'
    end
  end
end