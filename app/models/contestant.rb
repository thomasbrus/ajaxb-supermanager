require 'csv'

class Contestant < ActiveRecord::Base
  attr_accessor :team_name

  validates_presence_of :email, :name
  validates_uniqueness_of :email

  belongs_to :team

  has_one :superteam
  has_many :login_requests, dependent: :destroy

  scope :sorted, -> { order(created_at: :asc) }
  scope :sorted_alphabetically, ->{ order(name: :asc) }

  def self.has_superteam
    all.reject { |contestant| contestant.superteam.nil? }
  end

  def name_with_team
    team.present? ? "#{name} (#{team.name})" : name
  end

  def self.as_csv
    CSV.generate(col_sep: ';') do |csv|
      sorted.find_each do |contestant|
        next unless contestant.superteam.present? && contestant.superteam.valid?

        superteam = contestant.superteam

        # Thomas Brus thomas.brus@me.com
        csv.add_row([contestant.name.strip, contestant.email.strip, contestant.team.try(:name)])

        # Code  Naam  Club  Pos
        csv.add_row(%w(Code Naam Club Pos))

        # 1 Jeroen Zoet PSV a
        csv.add_row(superteam.goalkeeper.to_csv)

        # ... ...
        csv.add_row(superteam.defender_a.to_csv)

        # ... ...
        csv.add_row(superteam.defender_b.to_csv)

        # ... ...
        csv.add_row(superteam.defender_c.to_csv)

        # ... ...
        csv.add_row(superteam.defender_d.to_csv)

        # ... ...
        csv.add_row(superteam.midfielder_a.to_csv)

        # ... ...
        csv.add_row(superteam.midfielder_b.to_csv)

        # ... ...
        csv.add_row(superteam.midfielder_c.to_csv)

        # ... ...
        csv.add_row(superteam.forward_a.to_csv)

        # ... ...
        csv.add_row(superteam.forward_b.to_csv)

        # ... ...
        csv.add_row(superteam.forward_c.to_csv)

        # Bonus
        csv.add_row(%w(Bonus))

        # 9 Aaron Meijers ado b
        csv.add_row(superteam.bonus_player.to_csv)

        # Coach
        csv.add_row(%w(Coach))

        # 25 Zelkjo Petrovic ado coach
        csv.add_row(superteam.coach.to_csv)

        # ...
        csv.add_row(%w())
        csv.add_row(%w())
      end
    end
  end

end
