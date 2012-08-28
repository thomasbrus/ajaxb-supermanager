require 'csv'

namespace :players do
  desc "Import players from db/data/players.csv"
  task :import => :environment do
    file = Rails.root.join *%w(db data players.csv)
    CSV.open(file, col_sep: ';') do |csv|
      csv.each do |code, name, club, position, value|
        # Skip title and header row
        next if csv.lineno <= 2
        params = { code: code.to_i, name: name, club: Club.find_by_shorthand(club), value: value.to_i }
        case position
        when 'a'
          Goalkeeper.create params
        when 'b'
          Defender.create params
        when 'c'
          Midfielder.create params
        when 'd'
          Forward.create params
        when 'Coach'
          params.delete :value
          Coach.create params
        end
      end
    end
  end

  desc "Remove all players from the database"
  task :clear => :environment do
    Player.destroy_all
  end
end
