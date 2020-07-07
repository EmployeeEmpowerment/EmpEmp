# frozen_string_literal: true

require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index' do
    get companies_url
    assert_response :success
  end

  test 'should get show' do
    get company_url(companies(:facebook))
    assert_response :success
  end

  test 'should get edit' do
    sign_in users(:one)
    get edit_company_url(companies(:facebook))
    assert_response :success
  end

  test 'should get redirected for edit w/o user' do
    get edit_company_url(companies(:facebook))
    assert_redirected_to new_user_session_url
  end

  test 'should get redirected for new w/o user' do
    get new_company_url
    assert_redirected_to new_user_session_url
  end

  test 'should get new' do
    sign_in users(:one)
    get new_company_url
    assert_response :success
  end

  test 'should create company' do
    sign_in users(:one)
    assert_difference('Company.count') do
      post companies_url, params: { company: { name: 'Disney', ceo: 'Walt Disney', ceo_annual_salary: 1,
                                               ceo_annual_bonus: 10, ceo_annual_sold_shares: 100,
                                               ceo_annual_stock_award: 1000, stock_isin: 'US30303M1666',
                                               ceo_shares: 500_000 } }
    end

    company = Company.find_by(stock_isin: 'US30303M1666')
    assert_equal 1111, company.ceo_total_comp
    assert_redirected_to company_path(Company.last)
  end
end
