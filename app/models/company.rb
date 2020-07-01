# frozen_string_literal: true

# Company Model
class Company < ApplicationRecord
  include RatingsHtml

  has_many :jobs, dependent: :destroy
  has_many :executives, dependent: :destroy
  has_many :employee_ratings, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }
  validates :ceo, length: { minimum: 4 }

  def exec_diverse_score_html(img_height = 120)
    str = exec_gender_score(img_height) + exec_race_score(img_height)
    # rubocop:disable Rails/OutputSafety
    str.html_safe
    # rubocop:enable Rails/OutputSafety
  end

  # rubocop:disable Metrics/AbcSize
  def rating_stats_html
    return "(<span class='count'>0</span> ratings)".html_safe if employee_ratings.none?

    avg = rating_avg

    fraction = avg.to_f - avg.to_i

    half = true if fraction > 0.25 && fraction < 0.75

    avg += 1 if fraction > 0.75

    str = "<b class='rating'>" + rating_avg.to_s + '</b>' + rating_hearts_html(avg, half)
    str += " (<span class='count'>" + employee_ratings.count.to_s
    str += '</span> ' + 'rating'.pluralize(employee_ratings.count) + ')'

    # rubocop:disable Rails/OutputSafety
    str.html_safe
    # rubocop:enable Rails/OutputSafety
    # rubocop:enable Metrics/AbcSize
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
