# frozen_string_literal: true

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'should not save company without name' do
    company = Company.new
    assert_not company.save, 'Saved company without name!'
  end

  test 'should not save company when CEO < 4 chars' do
    company = Company.new
    company.name = 'Test Co.'
    company.ceo = 'Ed'
    assert_not company.save, 'Saved company with 2 charachter CEO!'
  end

  test 'should save valid company' do
    company = Company.new
    company.name = 'Valid Co.'
    company.ceo = 'Ed Valid'
    assert company.save, 'Failed to save company with valid info!'
  end
end
