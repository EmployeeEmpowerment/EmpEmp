# frozen_string_literal: true

# Adding Omniauth Fields to Users
class AddOmniauthToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :provider
      t.string :uid
    end
  end
end
