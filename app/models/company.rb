# frozen_string_literal: true

# Company Model
class Company < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :jobs
  # rubocop:enable Rails/HasManyOrHasOneDependent
  has_many :executives, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }
  validates :ceo, length: { minimum: 4 }

  def exec_diverse_score_html(img_height = 120)
    str = exec_gender_score(img_height) + exec_race_score(img_height)
    # rubocop:disable Rails/OutputSafety
    str.html_safe
    # rubocop:enable Rails/OutputSafety
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
end
