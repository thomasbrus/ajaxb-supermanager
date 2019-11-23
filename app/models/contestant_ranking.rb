require 'csv'

class ContestantRanking < ActiveRecord::Base
  validates :position, presence: true
  validates :contestant_name, presence: true
  validates :total_score, presence: true
  validates :weekly_score, presence: true
  validates :position, presence: true

  belongs_to :weekly_ranking

  def position_to_emoji
    case position
    when 1 then "🥇"
    when 2 then "🥈"
    when 3 then "🥉"
    end
  end
end
