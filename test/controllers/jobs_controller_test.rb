# frozen_string_literal: true

require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get redirected for index w/o user' do
    get jobs_url
    assert_redirected_to new_user_session_url
  end

  test 'should get index' do
    sign_in users(:one)
    get jobs_url
    assert_response :success
  end

  test 'should get redirected for edit w/o user' do
    get edit_job_url(jobs(:facebook_cashier))
    assert_redirected_to new_user_session_url
  end

  test 'should get redirected for edit w/ wrong user' do
    sign_in users(:two)
    get edit_job_url(jobs(:facebook_cashier))
    assert_redirected_to root_path
  end

  test 'should get redirected for new w/o user' do
    get new_job_url
    assert_redirected_to new_user_session_url
  end

  test 'should get new' do
    sign_in users(:one)
    get new_job_url
    assert_response :success
  end
end
