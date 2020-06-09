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
  devise :omniauthable, omniauth_providers: [:linkedin]

  validates :year_of_birth, numericality: { only_integer: true, allow_nil: true }
  validates :year_of_birth, length: { maximum: 4 }
  validates :email, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }, unless: -> { from_omniauth? }

  def self.from_omniauth(auth)
    existing_user = User.find_by email: auth.info.email

    unless existing_user.nil?
      existing_user.provider = auth.provider
      existing_user.uid = auth.uid
      existing_user.save
      return existing_user
    end

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # assuming the user model has a name
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def from_omniauth?
    provider && uid
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.linkedin_data']) && session['devise.linkedin_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def display
    "<img src='#{gravatar_url}'>"
  end
end
