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

  test 'Overall rating has correct value' do
    company = companies(:meditech)
    expected = "(<span class='count'>0</span> ratings)"
    assert expected == company.rating_stats_html, 'Failed to get correct overall rating!'
  end

  test 'Diversity score has correct bad value' do
    company = companies(:facebook)
    expected = "<img src='/gender_undiverse_exec.png' height='120' alt='Gender Exclusionary Executive Team' "
    expected += "title='Gender Exclusionary Executive Team'><img src='/race_undiverse_exec.png' height='120' "
    expected += "alt='Racially Exclusionary Executive Team' title='Racially Exclusionary Executive Team'>"
    assert company.exec_diverse_score_html == expected, 'Failed to get correct bad diversity score!'
  end

  test 'Diversity score has correct good value' do
    company = companies(:affectiva)
    expected = "<img src='/gender_diverse_exec.png' height='120' alt='Gender Inclusive Executive Team' "
    expected += "title='Gender Inclusive Executive Team'><img src='/race_diverse_exec.png' height='120' "
    expected += "alt='Racially Inclusive Executive Team' title='Racially Inclusive Executive Team'>"

    assert company.exec_diverse_score_html == expected, 'Failed to get correct good diversity score!'
  end

  test 'Sort value is accurate' do
    company = companies(:facebook)
    assert company.sort_value.zero?, 'Sort value is incorrect!'
  end
end
