require 'csv'

namespace :clubs do
  desc "Set up this season's clubs"
  task :setup => :environment do
    ActiveRecord::Base.transaction do
      Club.destroy_all

      # Set up clubs (season 2020 - 2021)
      Club.create!(name: 'ADO Den Haag', shorthand: 'ado')
      Club.create!(name: 'Ajax', shorthand: 'ajax')
      Club.create!(name: 'AZ', shorthand: 'az')
      Club.create!(name: 'Emmen', shorthand: 'emmen')
      Club.create!(name: 'Feyenoord', shorthand: 'fey')
      Club.create!(name: 'Fortuna', shorthand: 'fortuna')
      Club.create!(name: 'FC Groningen', shorthand: 'gro')
      Club.create!(name: 'FC Twente', shorthand: 'twe')
      Club.create!(name: 'SC Heerenveen', shorthand: 'heer')
      Club.create!(name: 'Heracles Almelo', shorthand: 'heracles')
      Club.create!(name: 'PEC Zwolle', shorthand: 'pec')
      Club.create!(name: 'PSV', shorthand: 'psv')
      Club.create!(name: 'RKC', shorthand: 'rkc')
      Club.create!(name: 'Sparta', shorthand: 'spa')
      Club.create!(name: 'FC Utrecht', shorthand: 'utr')
      Club.create!(name: 'Vitesse', shorthand: 'vitesse')
      Club.create!(name: 'VVV', shorthand: 'vvv')
      Club.create!(name: 'Willem II', shorthand: 'willem 2')
    end
  end
end
