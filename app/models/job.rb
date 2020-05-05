# frozen_string_literal: true

# Job Model
class Job < ApplicationRecord
  belongs_to :user
  belongs_to :company

  validates :user_id, presence: true
  validates :company_id, presence: true
  validates :title, presence: true
  validates :pay_period, presence: true,
                         unless: proc { |a| a.pay_rate.blank? }
  validates :start_date, presence: true
  validate :valid_pay_range?

  def valid_pay_range?
    return if end_date.nil?

    errors.add('Start date is', 'after end date.') unless end_date > start_date
  end
end
