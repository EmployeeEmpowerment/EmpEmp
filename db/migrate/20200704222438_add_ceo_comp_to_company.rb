# frozen_string_literal: true

# CEO Compensation Migration
class AddCeoCompToCompany < ActiveRecord::Migration[6.0]
  def change
    change_table :companies, bulk: true do |t|
      t.integer :ceo_annual_salary
      t.integer :ceo_annual_bonus
      t.integer :ceo_shares
      t.integer :ceo_annual_sold_shares
      t.integer :ceo_annual_stock_award
      t.string :stock_isin
    end
    add_index :companies, :stock_isin, unique: true
  end
end
