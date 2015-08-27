# encoding: utf-8

# Set up clubs (season 2015 - 2016)
Club.create!(name: 'ADO Den Haag', shorthand: 'ado')
Club.create!(name: 'AFC Ajax', shorthand: 'aja')
Club.create!(name: 'AZ', shorthand: 'az')
Club.create!(name: 'SC Cambuur', shorthand: 'cam')
Club.create!(name: 'Feyenoord', shorthand: 'fey')
Club.create!(name: 'De Graafschap', shorthand: 'gra')
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

# Sponsor
Sponsor.create!(name: 'Café Koenders', url: 'http://koenders-zalencentrum.nl', logo: 'koenders.jpg')

# Contestants
Contestant.create!(name: 'Thomas Brus', email: 'thomas.brus@me.com', is_admin: true)
Contestant.create!(name: 'Nico Huntink', email: 'hunti048@planet.nl', is_admin: true)
