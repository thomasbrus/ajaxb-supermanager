class Superteam < ActiveRecord::Base
  belongs_to :contestant
  belongs_to :coach
  belongs_to :bonus_player, class_name: "Player"
  belongs_to :defender_a, class_name: "Defender"
  belongs_to :defender_b, class_name: "Defender"
  belongs_to :defender_c, class_name: "Defender"
  belongs_to :defender_d, class_name: "Defender"
  belongs_to :midfielder_a, class_name: "Midfielder"
  belongs_to :midfielder_b, class_name: "Midfielder"
  belongs_to :midfielder_c, class_name: "Midfielder"
  belongs_to :midfielder_d, class_name: "Midfielder"
  belongs_to :forward_a, class_name: "Forward"
  belongs_to :forward_b, class_name: "Forward"
  belongs_to :forward_c, class_name: "Forward"
  validates_presence_of :goal_keeper, :bonus_player, :coach
    :defender_a, :defender_b, :defender_c, :defender_d,
    :midfielder_a, :midfielder_b, :midfielder_c, :midfielder_d,
    :forward_a, :forward_b, :forward_c
end

