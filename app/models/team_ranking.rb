require 'csv'

class TeamRanking < ActiveRecord::Base
  validates :position, presence: true
  validates :team_name, presence: true
  validates :score, presence: true

  belongs_to :weekly_ranking
end
