class CsvFilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @files = pagy(CsvFile.where(user_id: current_user.id))
  end
end
