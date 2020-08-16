# frozen_string_literal: true

# Migration to add legal fields to User
class AddLegalReqsToUser < ActiveRecord::Migration[6.0]
  change_table :users, bulk: true do |t|
    t.boolean :unsubscribe_all
    t.boolean :agreed_to_tos
  end
end
