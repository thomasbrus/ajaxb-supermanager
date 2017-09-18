require 'csv'

class TeamRanking < ActiveRecord::Base
  validates :team_name, presence: true
  validates :score, presence: true

  def self.parse(contents)
    csv = CSV.parse(contents, col_sep: ';')

    csv = csv.drop(3)
    csv = csv.drop_while { |row| !row[9].nil? }
    csv = csv.drop(2)
    csv = csv.take_while { |row| !row[0].nil? }

    csv.map(&public_method(:parse_row))
  end

  def self.parse_row(row)
    raise ArgumentError.new(row.inspect) unless row[9] && row[10]
    new(team_name: row[9], score: row[10])
  end
end
