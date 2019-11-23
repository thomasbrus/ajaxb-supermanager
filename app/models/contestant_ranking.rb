require 'csv'

class ContestantRanking < ActiveRecord::Base
  validates :position, presence: true
  validates :contestant_name, presence: true
  validates :total_score, presence: true
  validates :weekly_score, presence: true
  validates :position, presence: true

  belongs_to :weekly_ranking
end
