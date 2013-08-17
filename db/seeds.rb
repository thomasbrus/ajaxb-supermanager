# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Set up clubs (season 2012 - 2013)
Club.create(name: 'ADO Den Haag', shorthand: 'ADO')
Club.create(name: 'AFC Ajax', shorthand: 'aja')
Club.create(name: 'AZ', shorthand: 'az')
Club.create(name: 'FC Groningen', shorthand: 'gro')
Club.create(name: 'FC Twente', shorthand: 'twe')
Club.create(name: 'FC Utrecht', shorthand: 'utr')
Club.create(name: 'Feyenoord', shorthand: 'fey')
Club.create(name: 'Go Ahead Eagles', shorthand: 'gae')
Club.create(name: 'Heracles Almelo', shorthand: 'Heracles')
Club.create(name: 'NAC Breda', shorthand: 'nac')
Club.create(name: 'N.E.C.', shorthand: 'nec')
Club.create(name: 'PEC Zwolle', shorthand: 'PEC')
Club.create(name: 'PSV', shorthand: 'psv')
Club.create(name: 'RKC', shorthand: 'rkc')
Club.create(name: 'Roda JC', shorthand: 'rod')
Club.create(name: 'SC Cambuur', shorthand: 'cam')
Club.create(name: 'sc Heerenveen', shorthand: 'hee')
Club.create(name: 'Vitesse', shorthand: 'vit')

# Default sponsor
Sponsor.create(name: 'Voorbeeldsponsor', url: '/', logo: 'example.jpg')
