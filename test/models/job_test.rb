# frozen_string_literal: true

require 'test_helper'

class JobTest < ActiveSupport::TestCase
  test 'should not save job without title' do
    job = Job.new
    job.company_id = companies(:affectiva).id
    job.user_id = users(:two).id
    job.startdate = Time.zone.yesterday
    job.enddate = Time.zone.today
    job.pay_rate = '13.50'
    job.pay_period = 'H'
    assert_not job.save, 'Saved job without title!'
  end

  test 'should not save job when paid w/o period' do
    job = Job.new
    job.company_id = companies(:affectiva).id
    job.user_id = users(:two).id
    job.title = 'Chief Happiness Officer'
    job.startdate = Time.zone.yesterday
    job.enddate = Time.zone.today
    job.pay_rate = '13.50'
    assert_not job.save, 'Saved job when paid without period!'
  end

  test 'should save valid job' do
    job = Job.new
    job.company_id = companies(:affectiva).id
    job.user_id = users(:two).id
    job.title = 'Chief Happiness Officer'
    job.startdate = Time.zone.yesterday
    job.enddate = Time.zone.today
    job.pay_rate = '13.50'
    job.pay_period = 'H'
    assert job.save, 'Failed to save job with valid info!'
  end

  test 'should save without enddate' do
    job = Job.new
    job.company_id = companies(:affectiva).id
    job.user_id = users(:two).id
    job.title = 'Chief Happiness Officer'
    job.startdate = Time.zone.yesterday
    job.pay_rate = '13.50'
    job.pay_period = 'H'
    assert job.save, 'Failed to save job withput enddate!'
  end

  test 'start date must come first' do
    job = Job.new
    job.company_id = companies(:affectiva).id
    job.user_id = users(:two).id
    job.title = 'Chief Happiness Officer'
    job.startdate = Time.zone.today
    job.enddate = Time.zone.yesterday
    job.pay_rate = '13.50'
    job.pay_period = 'H'
    assert_not job.save, 'Saved job when start date is after end date!'
  end
end
