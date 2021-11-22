class FailedContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @contacts = pagy(FailedContact.where(user_id: current_user.id))
  end
end
