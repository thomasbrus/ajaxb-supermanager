require 'csv'

namespace :players do
  desc "Import players from db/data/players.csv"
  task :import => :environment do
    file = Rails.root.join('db', 'data', 'players.csv')

    ActiveRecord::Base.transaction do
      CSV.foreach(file, col_sep: ';') do |code, name, club, position, value|
        if name.blank? or club.blank? or position.blank?
          Logger.new(STDOUT).warn("Skipping line: #{code};#{name};#{club};#{position};#{value}")
          next
        end

        club = Club.find_by_shorthand(club.strip.downcase) || Club.find_by_name(club.strip)
        attributes = { code: code.to_i, name: name.strip, club: club, value: value.to_i }
        case position.strip
        when 'a'
          Goalkeeper.create!(attributes)
        when 'b'
          Defender.create!(attributes)
        when 'c'
          Midfielder.create!(attributes)
        when 'd'
          Forward.create!(attributes)
        when /coach/i
          attributes.delete :value
          Coach.create!(attributes)
        end
      end
    end
  end

  desc "Remove all players from the database"
  task :clear => :environment do
    Player.destroy_all
    Coach.destroy_all
  end
end
