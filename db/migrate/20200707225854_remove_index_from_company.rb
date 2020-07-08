# frozen_string_literal: true

# Remove unique index
class RemoveIndexFromCompany < ActiveRecord::Migration[6.0]
  def change
    remove_index :companies, :stock_isin
  end
end
