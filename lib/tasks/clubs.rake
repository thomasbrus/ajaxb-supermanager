require 'csv'

namespace :clubs do
  desc "Set up this season's clubs"
  task :setup => :environment do
    ActiveRecord::Base.transaction do
      Club.destroy_all

      # Set up clubs (season 2017 - 2018)
      Club.create!(name: 'ADO Den Haag', shorthand: 'ado')
      Club.create!(name: 'AFC Ajax', shorthand: 'aja')
      Club.create!(name: 'AZ', shorthand: 'az')
      Club.create!(name: 'Go Ahead Eagles', shorthand: 'gae')
      Club.create!(name: 'Feyenoord', shorthand: 'fey')
      Club.create!(name: 'Sparta', shorthand: 'spa')
      Club.create!(name: 'FC Groningen', shorthand: 'gro')
      Club.create!(name: 'SC Heerenveen', shorthand: 'hee')
      Club.create!(name: 'Heracles Almelo', shorthand: 'her')
      Club.create!(name: 'N.E.C.', shorthand: 'nec')
      Club.create!(name: 'Roda JC', shorthand: 'rod')
      Club.create!(name: 'PEC Zwolle', shorthand: 'pec')
      Club.create!(name: 'PSV', shorthand: 'psv')
      Club.create!(name: 'Excelsior', shorthand: 'exc')
      Club.create!(name: 'FC Twente', shorthand: 'twe')
      Club.create!(name: 'FC Utrecht', shorthand: 'utr')
      Club.create!(name: 'Vitesse', shorthand: 'vit')
      Club.create!(name: 'Willem II', shorthand: 'wil')
    end
  end
end
