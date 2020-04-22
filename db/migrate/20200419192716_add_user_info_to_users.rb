# frozen_string_literal: true

# Adding More User Fields
class AddUserInfoToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :private, :boolean
    add_column :users, :year_of_birth, :string
    add_column :users, :gender, :string
    add_column :users, :race, :string
    add_column :users, :lgbtqia_plus, :boolean
    add_column :users, :immigrant, :boolean
    add_column :users, :expat, :boolean
    add_column :users, :has_disability, :boolean
    add_column :users, :veteran, :boolean
  end
end
