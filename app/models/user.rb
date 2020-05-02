# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  include Gravtastic
  gravtastic size: 50

  has_many :jobs, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :year_of_birth, numericality: { only_integer: true, allow_nil: true }
  validates :year_of_birth, length: { maximum: 4 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def display
    "<img src='#{gravatar_url}'>"
  end
end
