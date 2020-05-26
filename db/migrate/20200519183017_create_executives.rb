# frozen_string_literal: true

# Migration for Executives
class CreateExecutives < ActiveRecord::Migration[6.0]
  def change
    create_table :executives do |t|
      t.string :name
      t.string :title
      t.string :gender
      t.string :race
      t.date :start_date
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
