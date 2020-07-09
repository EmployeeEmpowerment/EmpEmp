# frozen_string_literal: true

# Migration converting Annual Sold Shares to BIG Int
class ConvertSharesSoldToBigintInCompany < ActiveRecord::Migration[6.0]
  def up
    change_column :companies, :ceo_annual_sold_shares, :bigint
  end

  def down
    change_column :companies, :ceo_annual_sold_shares, :int
  end
end
