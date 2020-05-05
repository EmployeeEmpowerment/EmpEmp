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
  validates :startdate, presence: true
  validate :valid_pay_range?

  def valid_pay_range?
    return if enddate.nil?

    errors.add('Startdate is', 'after enddate.') unless enddate > startdate
  end
end
