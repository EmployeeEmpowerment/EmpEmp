# frozen_string_literal: true

require 'test_helper'

class ExecutivesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get edit' do
    sign_in users(:one)
    get edit_company_executive_url(companies(:facebook), executives(:one))
    assert_response :success
  end

  test 'should get redirected for edit w/o user' do
    get edit_company_executive_url(companies(:facebook), executives(:one))
    assert_redirected_to new_user_session_url
  end

  test 'should get redirected for new w/o user' do
    get new_company_executive_url(companies(:facebook))
    assert_redirected_to new_user_session_url
  end

  test 'should get new' do
    sign_in users(:one)
    get new_company_executive_url(companies(:facebook))
    assert_response :success
  end
end
