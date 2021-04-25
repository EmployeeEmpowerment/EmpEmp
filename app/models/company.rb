# frozen_string_literal: true

# Company Model
class Company < ApplicationRecord
  include RatingsHtml

  has_many :jobs, dependent: :destroy
  has_many :executives, dependent: :destroy
  has_many :employee_ratings, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }
  validates :ceo, length: { minimum: 4 }
  validates :stock_isin, uniqueness: true, format: { with: /\A[A-Z]{2}[A-Z0-9]{9}[0-9]{1}\z/ },
                         unless: proc { |c| c.stock_isin.blank? }
  validates :ceo_annual_sold_shares, numericality: { only_integer: true, greater_than_or_equal_to: 0 },
                                     unless: proc { |c| c.ceo_annual_sold_shares.blank? }
  validates :ceo_shares, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_blank: true }
  validates :ceo_annual_bonus, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :ceo_annual_salary, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def ceo_total_comp
    total = 0
    [ceo_annual_stock_award, ceo_annual_salary, ceo_annual_bonus, ceo_annual_sold_shares].each do |value|
      total += value unless value.nil?
    end
    total
  end

  def exec_diverse_score_html(img_height = 120)
    str = exec_gender_score(img_height) + exec_race_score(img_height)
    # rubocop:disable Rails/OutputSafety
    str.html_safe
    # rubocop:enable Rails/OutputSafety
  end

  def rating_stats_html
    return "(<span class='count'>0</span> ratings)".html_safe if employee_ratings.none?

    avg = rating_avg

    fraction = avg.to_f - avg.to_i

    half = true if fraction > 0.25 && fraction < 0.75

    avg += 1 if fraction > 0.75

    str = "<b class='rating'>#{rating_avg}</b>#{rating_hearts_html(avg, half)}"
    str += " (<span class='count'>#{employee_ratings.count}"
    str += "</span> #{'rating'.pluralize(employee_ratings.count)})"

    # rubocop:disable Rails/OutputSafety
    str.html_safe
    # rubocop:enable Rails/OutputSafety
  end

  def sort_value
    return 0 if employee_ratings.none?

    avg = rating_avg
    avg * 100 + employee_ratings.count
  end

  private

  def non_male_count
    non_male = ceo_gender == 'M' ? 0 : 1

    executives.each do |exec|
      non_male += 1 unless exec.gender == 'M'
    end

    non_male
  end

  def exec_gender_score(img_height)
    if (non_male_count + 0.0) / (executives.count + 1) > 0.24999
      text = 'Gender Inclusive Executive Team'
      "<img src='/gender_diverse_exec.png' height='#{img_height}' alt='#{text}' title='#{text}'>"
    else
      text = 'Gender Exclusionary Executive Team'
      "<img src='/gender_undiverse_exec.png' height='#{img_height}' alt='#{text}' title='#{text}'>"
    end
  end

  def non_white_count
    non_white = ceo_race == 'W' ? 0 : 1

    executives.each do |exec|
      non_white += 1 unless exec.race == 'W'
    end

    non_white
  end

  def exec_race_score(img_height)
    if (non_white_count + 0.0) / (executives.count + 1) > 0.24999
      text = 'Racially Inclusive Executive Team'
      "<img src='/race_diverse_exec.png' height='#{img_height}' alt='#{text}' title='#{text}'>"
    else
      text = 'Racially Exclusionary Executive Team'
      "<img src='/race_undiverse_exec.png' height='#{img_height}' alt='#{text}' title='#{text}'>"
    end
  end

  def rating_avg
    return 0 if employee_ratings.none?

    total = 0

    employee_ratings.each do |rating|
      total += rating.value
    end

    total.to_f / employee_ratings.count
  end
end
