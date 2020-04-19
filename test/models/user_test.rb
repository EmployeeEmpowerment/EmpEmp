# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without email' do
    user = User.new
    assert_not user.save, 'Saved user without email!'
  end

  test 'save user' do
    user = User.new
    user.email = 'test@server.com'
    user.password = 'notarealpassword'
    assert user.save, 'Failed to save user'
  end

  test 'invalid email' do
    user = User.new
    user.email = 'testserver.com'
    user.password = 'notarealpassword'
    assert_not user.save, 'Saved w/ bad email'
  end

  test 'invalid password' do
    user = User.new
    user.email = 'testserver.com'
    user.password = 'n'
    assert_not user.save, 'Saved w/ bad password'
  end
end
