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
        columns << contestant.team.try(:name) || ' '
        if contestant.superteam.present? && contestant.superteam.valid?
          columns << contestant.superteam.coach.try(:name) || ' '
          columns << contestant.superteam.bonus_player.try(:name) || ' '
          columns << contestant.superteam.goalkeeper.try(:name) || ' '
          columns << contestant.superteam.defender_a.try(:name) || ' '
          columns << contestant.superteam.defender_b.try(:name) || ' '
          columns << contestant.superteam.defender_c.try(:name) || ' '
          columns << contestant.superteam.defender_d.try(:name) || ' '
          columns << contestant.superteam.midfielder_a.try(:name) || ' '
          columns << contestant.superteam.midfielder_b.try(:name) || ' '
          columns << contestant.superteam.midfielder_c.try(:name) || ' '
          columns << contestant.superteam.forward_a.try(:name) || ' '
          columns << contestant.superteam.forward_b.try(:name) || ' '
          columns << contestant.superteam.forward_c.try(:name) || ' '
        end
        csv.add_row(columns)
      end
    end
  end

end
