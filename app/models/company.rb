# frozen_string_literal: true

# Company Model
class Company < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :jobs
  # rubocop:enable Rails/HasManyOrHasOneDependent

  validates :name, presence: true, length: { minimum: 3 }
  validates :ceo, length: { minimum: 4 }
end
