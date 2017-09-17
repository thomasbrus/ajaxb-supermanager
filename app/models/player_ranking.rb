require 'csv'

class PlayerRanking < ActiveRecord::Base
  validates :player_name, presence: true
  validates :player_club, presence: true
  validates :player_position, presence: true
  validates :player_value, presence: true
  validates :score, presence: true

  def self.parse(contents)
    csv = CSV.parse(contents, col_sep: ';', external_encoding: "ISO8859-1", internal_encoding: "utf-8")

    csv = csv.drop_while { |row| !(row[0] =~ /score per speler/i) }
    csv = csv.drop(2)

    csv.flat_map(&public_method(:parse_row))
  end

  def self.parse_row(row)
    p1 = new(player_name: row[1], player_club: row[2], player_position: row[3], player_value: row[4], score: row[5])
    p2 = new(player_name: row[9], player_club: row[10], player_position: row[11], player_value: row[12], score: row[13])

    [p1, p2]
  end
end
