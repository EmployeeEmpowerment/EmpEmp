# frozen_string_literal: true

# Migration to add demographics for the CEO
class AddCeoDemographicsToCompany < ActiveRecord::Migration[6.0]
  def change
    change_table :companies, bulk: true do |t|
      t.string :ceo_gender
      t.string :ceo_race
    end
  end
end
