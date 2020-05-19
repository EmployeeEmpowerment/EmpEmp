# frozen_string_literal: true

require 'test_helper'

class ExecutiveTest < ActiveSupport::TestCase
  test 'should not save exec without title' do
    executive = Executive.new
    executive.company_id = companies(:affectiva).id
    assert_not executive.save, 'Saved exec without title!'
  end

  test 'should not save exec without company' do
    executive = Executive.new
    executive.title = 'Chief Operating Officer'
    assert_not executive.save, 'Saved exec without company!'
  end

  test 'save exec' do
    executive = Executive.new
    executive.title = 'Chief Operating Officer'
    executive.company_id = companies(:affectiva).id
    assert executive.save, 'Failed to save exec'
  end
end
