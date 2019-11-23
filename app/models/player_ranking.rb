require 'csv'

class PlayerRanking < ActiveRecord::Base
  validates :position, presence: true
  validates :player_name, presence: true
  validates :player_club, presence: true
  validates :player_position, presence: true
  validates :player_value, presence: true
  validates :score, presence: true

  belongs_to :weekly_ranking
end
