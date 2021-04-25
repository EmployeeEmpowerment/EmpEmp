# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  include Gravtastic
  gravtastic size: 50

  has_many :jobs, dependent: :destroy
  has_many :employee_ratings, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:linkedin]

  validate :valid_year_of_birth?
  validates :email, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }, unless: -> { from_omniauth? }
  validates :agreed_to_tos, presence: true

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
      if (data = session['devise.linkedin_data']) && session['devise.linkedin_data']['extra']['raw_info'] && user.email.blank?
        user.email = data['email']
      end
    end
  end

  def display
    "<img src='#{gravatar_url}'>"
  end

  def valid_year_of_birth?
    return if year_of_birth.nil?
    return if year_of_birth.empty?

    errors.add('Year of birth', ' is invalid!') unless /^[12][0-9]{3}$/ =~ year_of_birth.to_s
  end
end
