class Superteam < ApplicationRecord
  belongs_to :contestant
  belongs_to :coach
  belongs_to :bonus_player, class_name: 'Player'
  belongs_to :goalkeeper, class_name: 'Goalkeeper'
  belongs_to :defender_a, class_name: 'Defender'
  belongs_to :defender_b, class_name: 'Defender'
  belongs_to :defender_c, class_name: 'Defender'
  belongs_to :defender_d, class_name: 'Defender'
  belongs_to :midfielder_a, class_name: 'Midfielder'
  belongs_to :midfielder_b, class_name: 'Midfielder'
  belongs_to :midfielder_c, class_name: 'Midfielder'
  belongs_to :forward_a, class_name: 'Forward'
  belongs_to :forward_b, class_name: 'Forward'
  belongs_to :forward_c, class_name: 'Forward'
  validates_presence_of :goalkeeper_id,
                        :bonus_player_id,
                        :coach_id,
                        :defender_a_id,
                        :defender_b_id,
                        :defender_c_id,
                        :defender_d_id,
                        :midfielder_a_id,
                        :midfielder_b_id,
                        :midfielder_c_id,
                        :forward_a_id,
                        :forward_b_id,
                        :forward_c_id
end
