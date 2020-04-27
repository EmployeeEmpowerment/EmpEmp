# frozen_string_literal: true

# Migration for jobs
class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.decimal :pay_rate
      t.string :pay_period
      t.date :startdate
      t.date :enddate
      t.references :company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
