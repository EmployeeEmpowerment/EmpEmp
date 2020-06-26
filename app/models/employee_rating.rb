# frozen_string_literal: true

# Employee Rating Model
class EmployeeRating < ApplicationRecord
  include RatingsHtml

  belongs_to :user
  belongs_to :company

  validates :company_id, presence: true
  validates :user_id, presence: true, uniqueness: { scope: :company_id }
  validates :value, numericality: { only_integer: true, greater_than: 0, less_than: 6 },
                    presence: true, length: { maximum: 1 }

  def value_html
    # rubocop:disable Rails/OutputSafety
    rating_hearts_html(value, false).html_safe
    # rubocop:enable Rails/OutputSafety
  end
end
