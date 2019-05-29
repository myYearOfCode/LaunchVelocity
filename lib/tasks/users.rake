namespace :users do
  desc "Runs the scraper on all Users"
  task :scrape => :environment do
    User.all.scrape
  end
end
