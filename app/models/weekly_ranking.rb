class WeeklyRanking < ActiveRecord::Base
  validates :date, presence: true

  has_many :contestant_rankings, dependent: :destroy
  has_many :team_rankings, dependent: :destroy
  has_many :player_rankings, dependent: :destroy

  ContestantRow = Struct.new(:position, :contestant_name, :total_score, :weekly_score)
  TeamRow = Struct.new(:position, :team_name, :score)
  PlayerRow = Struct.new(:position, :player_name, :player_club, :player_position, :player_value, :score)

  def self.current
    WeeklyRanking.order(:date).last
  end

  def previous
    WeeklyRanking.where('date < ?', date).order(:date).last
  end

  def next
    WeeklyRanking.where('date > ?', date).order(:date).first
  end

  def previous?
    previous.present?
  end

  def next?
    public_send(:next).present?
  end

  def parse!(rows)
    # Contestants (left)
    rows.to_a[3..52].each do |row|
      contestant_row = ContestantRow.new(*row.values.take(4))
      self.contestant_rankings.create!(contestant_row.to_h)
    end

    # Contestants (right)
    rows.to_a[3..29].each do |row|
      contestant_row = ContestantRow.new(*row.values.drop(8).take(4))
      self.contestant_rankings.create!(contestant_row.to_h)
    end

    # Teams (right)
    rows.to_a[35..52].each do |row|
      team_row = TeamRow.new(*row.values.drop(8).take(3))
      self.team_rankings.create!(team_row.to_h)
    end

    # Players (bottom left)
    rows.to_a[58..68].each do |row|
      player_row = PlayerRow.new(*row.values.take(6))
      self.player_rankings.create!(player_row.to_h)
    end

    # Players (bottom right)
    rows.to_a[58..68].each do |row|
      player_row = PlayerRow.new(*row.values.drop(8).take(6))
      self.player_rankings.create!(player_row.to_h)
    end
  end
end
