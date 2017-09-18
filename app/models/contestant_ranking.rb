require 'csv'

class ContestantRanking < ActiveRecord::Base
  validates :contestant_name, presence: true
  validates :total_score, presence: true

  def self.parse(contents)
    csv = CSV.parse(contents, col_sep: ';')

    csv = csv.drop(3)
    csv = csv.take_while { |row| !row[0].nil? }

    left = csv.map { |row| row.take(9)}
    right = csv.map { |row| row.drop(8) }.take_while { |row| !row[0].nil? }

    left.map(&public_method(:parse_columns)) + right.map(&public_method(:parse_columns))
  end

  def self.parse_columns(columns)
    raise ArgumentError unless columns[1] && columns[2]
    new(contestant_name: columns[1], total_score: columns[2])
  end
end
