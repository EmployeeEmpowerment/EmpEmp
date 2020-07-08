# frozen_string_literal: true

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # Filer tests ---------------------------------------------------------

  test 'should not save company without name' do
    company = Company.new
    assert_not company.save, 'Saved company without name!'
  end

  test 'should not save company when CEO < 4 chars' do
    company = Company.new
    company.name = 'Test Co.'
    company.ceo = 'Ed'
    assert_not company.save, 'Saved company with 2 character CEO!'
  end

  test 'should save valid company' do
    company = Company.new
    company.name = 'Valid Co.'
    company.ceo = 'Ed Valid'
    company.ceo_annual_salary = 250_000
    company.ceo_annual_bonus = 50_000
    company.ceo_annual_sold_shares = 25_000
    company.ceo_shares = 500_000
    company.stock_isin = 'US0917971006'
    company.ceo_annual_stock_award = 12_500
    assert company.save, 'Failed to save company with valid info!'
  end

  test 'should save valid company w/o ISIN' do
    company = Company.new
    company.name = 'ABC Co.'
    company.ceo = 'Lady Gaga'
    company.ceo_annual_salary = 250_000
    company.ceo_annual_bonus = 50_000
    company.ceo_annual_sold_shares = 25_000
    company.ceo_shares = 500_000
    company.ceo_annual_stock_award = 12_500
    company.stock_isin = ''
    assert company.save, 'Failed to save company w/o ISIN!'
  end

  test "shouldn't save negative ceo salary" do
    company = Company.new
    company.name = 'Valid Co.'
    company.ceo = 'Ed Valid'
    company.ceo_annual_salary = -1
    assert_not company.save, 'Saved company with negative salary!'
  end

  test "shouldn't save negative ceo bonus" do
    company = Company.new
    company.name = 'Valid Co.'
    company.ceo = 'Ed Valid'
    company.ceo_annual_bonus = -1
    assert_not company.save, 'Saved company with negative bonus!'
  end

  test "shouldn't save negative ceo shares" do
    company = Company.new
    company.name = 'Valid Co.'
    company.ceo = 'Ed Valid'
    company.ceo_shares = -1
    assert_not company.save, 'Saved company with negative shares!'
  end

  test "shouldn't save negative CEO stock award" do
    company = Company.new
    company.name = 'Valid Co.'
    company.ceo = 'Ed Valid'
    company.ceo_annual_stock_award = -1
    assert_not company.save, 'Saved company with negative CEO stock award!'
  end

  test "shouldn't save invalid ISIN" do
    company = Company.new
    company.name = 'Valid Co.'
    company.ceo = 'Ed Valid'
    company.stock_isin = 'KO'
    assert_not company.save, 'Saved company with invalid ISIN!'
  end

  test "shouldn't save duplicate ISIN" do
    company = Company.new
    company.name = 'Valid Co.'
    company.ceo = 'Ed Valid'
    company.stock_isin = 'US30303M1027'
    assert_not company.save, 'Saved company with duplicate ISIN!'
  end

  # Method Tests ---------------------------------------------------------

  test 'Overall rating has correct value' do
    company = companies(:meditech)
    expected = "(<span class='count'>0</span> ratings)"
    assert_equal expected, company.rating_stats_html, 'Failed to get correct overall rating!'
  end

  test 'Diversity score has correct bad value' do
    company = companies(:facebook)
    expected = "<img src='/gender_undiverse_exec.png' height='120' alt='Gender Exclusionary Executive Team' "
    expected += "title='Gender Exclusionary Executive Team'><img src='/race_undiverse_exec.png' height='120' "
    expected += "alt='Racially Exclusionary Executive Team' title='Racially Exclusionary Executive Team'>"
    assert_equal expected, company.exec_diverse_score_html, 'Failed to get correct bad diversity score!'
  end

  test 'Diversity score has correct good value' do
    company = companies(:affectiva)
    expected = "<img src='/gender_diverse_exec.png' height='120' alt='Gender Inclusive Executive Team' "
    expected += "title='Gender Inclusive Executive Team'><img src='/race_diverse_exec.png' height='120' "
    expected += "alt='Racially Inclusive Executive Team' title='Racially Inclusive Executive Team'>"

    assert_equal expected, company.exec_diverse_score_html, 'Failed to get correct good diversity score!'
  end

  test 'Sort value is accurate' do
    company = companies(:facebook)
    assert company.sort_value.zero?, 'Sort value is incorrect!'
  end

  test 'Total comp for fixture is accurate' do
    company = companies(:facebook)
    assert_equal 1_800_000_001, company.ceo_total_comp, 'Total comp for fixture is incorrect!'
  end

  test 'Total comp default is 0' do
    company = companies(:apple)
    assert_equal 0, company.ceo_total_comp, 'Total comp for fixture is incorrect!'
  end

  test 'Total comp is accurate' do
    company = Company.new
    company.name = 'Valid Co.'
    company.ceo = 'Ed Valid'
    company.ceo_annual_salary = 250_000
    company.ceo_annual_bonus = 50_000
    company.ceo_annual_sold_shares = 25_000
    company.ceo_annual_stock_award = 12_500
    company.save
    assert_equal 337_500, company.ceo_total_comp, 'Total comp is incorrect!'
  end
end
