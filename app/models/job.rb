# frozen_string_literal: true

# Job Model
class Job < ApplicationRecord
  belongs_to :user
  belongs_to :company

  validates :company, presence: true
  validates :title, presence: true
  validates :pay_period, presence: true,
                         unless: proc { |a| a.pay_rate.blank? }
  validates :startdate, presence: true
end
