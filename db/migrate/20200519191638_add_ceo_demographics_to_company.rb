# frozen_string_literal: true

# Migration to add demographics for the CEO
class AddCeoDemographicsToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :ceo_gender, :string
    add_column :companies, :ceo_race, :string
  end
end
