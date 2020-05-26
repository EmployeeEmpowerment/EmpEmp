# frozen_string_literal: true

# Company Model
class Company < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :jobs
  # rubocop:enable Rails/HasManyOrHasOneDependent
  has_many :executives, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }
  validates :ceo, length: { minimum: 4 }

  def exec_diverse_score_html
    str = exec_gender_score + exec_race_score
    # rubocop:disable Rails/OutputSafety
    str.html_safe
    # rubocop:enable Rails/OutputSafety
  end

  private

  def exec_gender_score
    non_male = ceo_gender == 'M' ? 0 : 1

    executives.each do |exec|
      non_male += 1 unless exec.gender == 'M'
    end

    if (non_male + 0.0) / (executives.count + 1) > 0.24999
      "<img src='/gender_diverse_exec.png' alt='Gender Inclusive Executive Team'>"
    else
      "<img src='/gender_undiverse_exec.png' alt='Gender Exclusionary Executive Team'>"
    end
  end

  def exec_race_score
    non_white = ceo_race == 'W' ? 0 : 1

    executives.each do |exec|
      non_white += 1 unless exec.race == 'W'
    end

    if (non_white + 0.0) / (executives.count + 1) > 0.24999
      "<img src='/race_diverse_exec.png' alt='Racially Inclusive Executive Team'>"
    else
      "<img src='/race_undiverse_exec.png' alt='Racially Exclusionary Executive Team'>"
    end
  end
end
