require 'csv'

namespace :superteams do
  desc "Clear all superteams"
  task :clear => :environment do
    Superteam.destroy_all
  end
end
