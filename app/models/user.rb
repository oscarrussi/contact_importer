class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :csv_files
  has_many :contacts
  has_many :failed_contacts
  validates_confirmation_of :password
  validates_presence_of :password_confirmation
end
