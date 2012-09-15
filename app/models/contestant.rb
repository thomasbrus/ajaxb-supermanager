require 'csv'

class Contestant < ActiveRecord::Base
  attr_accessor :team_name
  attr_accessible :email, :name, :team_id, :team_name
  validates_presence_of :email, :name
  validates_uniqueness_of :email
  belongs_to :team
  has_one :superteam
  has_many :login_requests, dependent: :destroy

  def name_with_team
    if team.present?
      "#{name} (#{team.name})"
    else
      name
    end
  end

  def self.as_csv
    CSV.generate(col_sep: ';') do |csv|
      csv << %w(Naam E-mailadres Ploeg Coach Bonusspeler Keeper Verdedigers - - - Middenvelders - - Aanvallers - -)
      self.order('created_at ASC').each do |contestant|
        columns = [contestant.name.strip, contestant.email.strip]
        if contestant.team.present?
          columns << contestant.team.name
        end
        if contestant.superteam.present? and contestant.superteam.valid?
          columns << contestant.superteam.coach.name
          columns << contestant.superteam.bonus_player.name
          columns << contestant.superteam.goalkeeper.name
          columns << contestant.superteam.defender_a.name
          columns << contestant.superteam.defender_b.name
          columns << contestant.superteam.defender_c.name
          columns << contestant.superteam.defender_d.name
          columns << contestant.superteam.midfielder_a.name
          columns << contestant.superteam.midfielder_b.name
          columns << contestant.superteam.midfielder_c.name
          columns << contestant.superteam.forward_a.name
          columns << contestant.superteam.forward_b.name
          columns << contestant.superteam.forward_c.name
        end
        csv.add_row(columns)

      end
    end
  end

end
