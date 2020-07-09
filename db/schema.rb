# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_709_184_956) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'companies', force: :cascade do |t|
    t.string 'name'
    t.string 'ceo'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'ceo_gender'
    t.string 'ceo_race'
    t.integer 'ceo_annual_salary'
    t.integer 'ceo_annual_bonus'
    t.integer 'ceo_shares'
    t.bigint 'ceo_annual_sold_shares'
    t.integer 'ceo_annual_stock_award'
    t.string 'stock_isin'
  end

  create_table 'employee_ratings', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'company_id', null: false
    t.string 'headline'
    t.integer 'value', limit: 2, null: false
    t.text 'pros'
    t.text 'cons'
    t.boolean 'discriminated'
    t.boolean 'discriminated_by_management'
    t.boolean 'harassed'
    t.boolean 'harassed_by_management'
    t.boolean 'housework_required'
    t.boolean 'included'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['company_id'], name: 'index_employee_ratings_on_company_id'
    t.index %w[user_id company_id], name: 'index_employee_ratings_on_user_id_and_company_id', unique: true
    t.index ['user_id'], name: 'index_employee_ratings_on_user_id'
  end

  create_table 'executives', force: :cascade do |t|
    t.string 'name'
    t.string 'title'
    t.string 'gender'
    t.string 'race'
    t.date 'start_date'
    t.bigint 'company_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['company_id'], name: 'index_executives_on_company_id'
  end

  create_table 'jobs', force: :cascade do |t|
    t.string 'title'
    t.decimal 'pay_rate'
    t.string 'pay_period'
    t.date 'start_date'
    t.date 'end_date'
    t.bigint 'company_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['company_id'], name: 'index_jobs_on_company_id'
    t.index ['user_id'], name: 'index_jobs_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'name'
    t.boolean 'private'
    t.string 'year_of_birth'
    t.string 'gender'
    t.string 'race'
    t.boolean 'lgbtqia_plus'
    t.boolean 'immigrant'
    t.boolean 'expat'
    t.boolean 'has_disability'
    t.boolean 'veteran'
    t.string 'provider'
    t.string 'uid'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'employee_ratings', 'companies'
  add_foreign_key 'employee_ratings', 'users'
  add_foreign_key 'executives', 'companies'
  add_foreign_key 'jobs', 'companies'
  add_foreign_key 'jobs', 'users'
end
