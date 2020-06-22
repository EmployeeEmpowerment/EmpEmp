# frozen_string_literal: true

# EmployeeRatings Migration
class CreateEmployeeRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :employee_ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :title
      t.integer :value, limit: 1, null: false
      t.text :pros
      t.text :cons
      t.boolean :discriminated
      t.boolean :discriminated_by_management
      t.boolean :harassed
      t.boolean :harassed_by_management
      t.boolean :housework_required
      t.boolean :included

      t.timestamps
    end

    add_index :employee_ratings, %i[user_id company_id], unique: true
  end
end
