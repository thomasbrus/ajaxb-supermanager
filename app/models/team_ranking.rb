require 'csv'

class TeamRanking < ApplicationRecord
  validates :position, presence: true
  validates :team_name, presence: true
  validates :score, presence: true

  belongs_to :weekly_ranking
end
