require 'csv'

namespace :players do
  desc "Import players from db/data/players.csv"
  task :import => :environment do
    file = Rails.root.join *%w(db data players.csv)
    CSV.foreach(file, col_sep: ';') do |code, name, club, position, value|
      next if name.blank? or club.blank? or position.blank?
      club = Club.find_by_shorthand(club.strip)   
      params = { code: code.to_i, name: name.strip, club: club, value: value.to_i }
      case position.strip
      when 'a'
        Goalkeeper.create params
      when 'b'
        Defender.create params
      when 'c'
        Midfielder.create params
      when 'd'
        Forward.create params
      when /coach/i
        params.delete :value
        Coach.create params
      end
    end
  end

  desc "Remove all players from the database"
  task :clear => :environment do
    Player.destroy_all
    Coach.destroy_all
  end
end
