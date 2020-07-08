# frozen_string_literal: true

# Executive Model
class Executive < ApplicationRecord
  belongs_to :company

  validates :company_id, presence: true
  validates :name, presence: true
  validates :title, presence: true
end
