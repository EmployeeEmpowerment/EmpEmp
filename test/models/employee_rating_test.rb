# frozen_string_literal: true

require 'test_helper'

class EmployeeRatingTest < ActiveSupport::TestCase
  test 'should not save rating without value' do
    rating = EmployeeRating.new
    rating.company_id = companies(:affectiva).id
    rating.user_id = users(:two).id
    assert_not rating.save, 'Saved rating without value!'
  end

  test 'Should save rating with valid value' do
    rating = EmployeeRating.new
    rating.company_id = companies(:affectiva).id
    rating.user_id = users(:two).id
    rating.value = 1
    assert rating.save, 'Failed to save rating with valid value!'
  end

  test 'Should not save rating with value too high' do
    rating = EmployeeRating.new
    rating.company_id = companies(:affectiva).id
    rating.user_id = users(:two).id
    rating.value = 6
    assert_not rating.save, 'Saved rating with value too high!'
  end

  test 'Should not save rating with value too low' do
    rating = EmployeeRating.new
    rating.company_id = companies(:affectiva).id
    rating.user_id = users(:two).id
    rating.value = 0
    assert_not rating.save, 'Saved rating with value too low!'
  end

  test 'Should not save rating without company' do
    rating = EmployeeRating.new
    rating.user_id = users(:two).id
    rating.value = 2
    assert_not rating.save, 'Saved rating without company!'
  end

  test 'Should not save rating without user' do
    rating = EmployeeRating.new
    rating.company_id = companies(:affectiva).id
    rating.value = 2
    assert_not rating.save, 'Saved rating without user!'
  end

  test 'Saved when user has duplicate ratings of a company!' do
    rating = EmployeeRating.new
    rating.company_id = companies(:affectiva).id
    rating.user_id = users(:two).id
    rating.value = 1
    rating.save
    rating = EmployeeRating.new
    rating.company_id = companies(:affectiva).id
    rating.user_id = users(:two).id
    rating.value = 2
    assert_not rating.save, 'Saved when user has duplicate ratings of a company!'
  end
end
