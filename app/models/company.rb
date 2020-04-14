# frozen_string_literal: true

# Company Model
class Company < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :ceo, length: { minimum: 4 }
end
