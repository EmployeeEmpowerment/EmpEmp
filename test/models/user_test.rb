# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without email' do
    user = User.new
    user.agreed_to_tos = true
    assert_not user.save, 'Saved user without email!'
  end

  test 'save user' do
    user = User.new
    user.email = 'test@server.com'
    user.password = 'notarealpassword'
    user.agreed_to_tos = true
    user.year_of_birth = 1984
    assert user.save, 'Failed to save user'
  end

  test 'save user w/ empty year' do
    user = User.new
    user.email = 'test@server.com'
    user.password = 'notarealpassword'
    user.agreed_to_tos = true
    user.year_of_birth = ''
    assert user.save, 'Failed to save user'
  end

  test 'invalid date #1' do
    user = User.new
    user.email = 'test@server.com'
    user.password = 'notarealpassword'
    user.agreed_to_tos = true
    user.year_of_birth = 29_999
    assert_not user.save, 'Saved user w/ invalid year'
  end

  test 'invalid date #2' do
    user = User.new
    user.email = 'test@server.com'
    user.password = 'notarealpassword'
    user.agreed_to_tos = true
    user.year_of_birth = '199t'
    assert_not user.save, 'Saved user w/ invalid year'
  end

  test 'No TOS Agreement' do
    user = User.new
    user.email = 'test@server.com'
    user.password = 'notarealpassword'
    assert_not user.save, 'Saved w/o TOS agreement'
  end

  test 'invalid email' do
    user = User.new
    user.email = 'testserver.com'
    user.password = 'notarealpassword'
    user.agreed_to_tos = true
    assert_not user.save, 'Saved w/ bad email'
  end

  test 'invalid password' do
    user = User.new
    user.email = 'testserver.com'
    user.password = 'n'
    user.agreed_to_tos = true
    assert_not user.save, 'Saved w/ bad password'
  end
end
