# frozen_string_literal: true

# Adding More User Fields
class AddUserInfoToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :name
      t.boolean :private
      t.string :year_of_birth
      t.string :gender
      t.string :race
      t.boolean :lgbtqia_plus
      t.boolean :immigrant
      t.boolean :expat
      t.boolean :has_disability
      t.boolean :veteran
    end
  end
end
