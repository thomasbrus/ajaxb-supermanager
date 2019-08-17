require 'csv'

namespace :clubs do
  desc "Set up this season's clubs"
  task :setup => :environment do
    ActiveRecord::Base.transaction do
      Club.destroy_all

      # Set up clubs (season 2019 - 2020)
      Club.create!(name: 'ADO Den Haag', shorthand: 'ado')
      Club.create!(name: 'Ajax', shorthand: 'ajax')
      Club.create!(name: 'AZ', shorthand: 'az')
      Club.create!(name: 'Emmen', shorthand: 'emmen')
      Club.create!(name: 'Excelsior', shorthand: 'exc')
      Club.create!(name: 'Feyenoord', shorthand: 'fey')
      Club.create!(name: 'Fortuna', shorthand: 'fortuna')
      Club.create!(name: 'De Graafschap', shorthand: 'graaf')
      Club.create!(name: 'FC Groningen', shorthand: 'gro')
      Club.create!(name: 'SC Heerenveen', shorthand: 'heer')
      Club.create!(name: 'Heracles Almelo', shorthand: 'heracles')
      Club.create!(name: 'NAC', shorthand: 'nac')
      Club.create!(name: 'PEC Zwolle', shorthand: 'pec')
      Club.create!(name: 'PSV', shorthand: 'psv')
      Club.create!(name: 'FC Utrecht', shorthand: 'utr')
      Club.create!(name: 'Vitesse', shorthand: 'vitesse')
      Club.create!(name: 'VVV', shorthand: 'vvv')
      Club.create!(name: 'Willem II', shorthand: 'willem 2')
    end
  end
end
