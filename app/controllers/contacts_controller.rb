class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def create
    byebug
  end
end