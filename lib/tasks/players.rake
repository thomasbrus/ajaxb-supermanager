require 'csv'

namespace :players do
  desc "Import players from db/data/players.csv"
  task :import => :environment do |t, args|
    file = Rails.root.join *%w(db data players.csv)
    CSV.foreach(file, col_sep: ';') do |code, name, club, position, value|
      params = { code: code, name: name, club: Club.find_by_shorthand(club) }
      case position
      when 'a'
        Goalkeeper.create! params
      when 'b'
        Defender.create! params
      when 'c'
        Midfielder.create! params
      when 'd'
        Forward.create! params
      when 'Coach'
        Coach.create! params.delete(:value)
      end
    end
  end
end
