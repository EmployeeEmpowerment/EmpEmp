# frozen_string_literal: true

require 'test_helper'
class AboutControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get coc' do
    get about_coc_url
    assert_response :success
  end

  test 'should get privacy policy' do
    get about_privacy_policy_url
    assert_response :success
  end

  test 'should get tos' do
    get about_tos_url
    assert_response :success
  end
end
