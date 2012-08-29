class Superteam < ActiveRecord::Base
  belongs_to :contestant
  belongs_to :coach
  belongs_to :bonus_player, class_name: "Player"
  has_many_and_belongs_to :players
  validates_with Validators::FormationValidator
end

