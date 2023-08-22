require 'csv'

namespace :clubs do
  desc "Set up this season's clubs"
  task setup: :environment do
    ActiveRecord::Base.transaction do
      Club.destroy_all

      # Set up clubs
      Club.create!(name: 'Ajax', shorthand: 'ajax')
      Club.create!(name: 'Almere', shorthand: 'almere')
      Club.create!(name: 'AZ', shorthand: 'az')
      Club.create!(name: 'Excelsior', shorthand: 'excelsior')
      Club.create!(name: 'FC Twente', shorthand: 'twe')
      Club.create!(name: 'FC Utrecht', shorthand: 'utr')
      Club.create!(name: 'Feyenoord', shorthand: 'fey')
      Club.create!(name: 'Fortuna', shorthand: 'fortuna')
      Club.create!(name: 'Go Ahead Eagles', shorthand: 'gae')
      Club.create!(name: 'Heracles', shorthand: 'heracles')
      Club.create!(name: 'N.E.C.', shorthand: 'nec')
      Club.create!(name: 'PEC', shorthand: 'pec')
      Club.create!(name: 'PSV', shorthand: 'psv')
      Club.create!(name: 'RKC', shorthand: 'rkc')
      Club.create!(name: 'SC Heerenveen', shorthand: 'heer')
      Club.create!(name: 'Sparta', shorthand: 'spa')
      Club.create!(name: 'Vitesse', shorthand: 'vitesse')
      Club.create!(name: 'Volendam', shorthand: 'volendam')
    end
  end
end
