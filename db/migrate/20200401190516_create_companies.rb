# frozen_string_literal: true

# Migration for CreateCompanies
class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :ceo

      t.timestamps
    end
  end
end
