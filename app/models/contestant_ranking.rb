require 'csv'

class ContestantRanking < ApplicationRecord
  validates :position, presence: true
  validates :contestant_name, presence: true
  validates :total_score, presence: true
  validates :weekly_score, presence: true
  validates :position, presence: true

  belongs_to :weekly_ranking

  def position_to_emoji
    case position
    when 1
      '🥇'
    when 2
      '🥈'
    when 3
      '🥉'
    end
  end
end
