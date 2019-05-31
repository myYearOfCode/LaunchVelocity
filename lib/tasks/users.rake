namespace :users do
  desc "Runs the scraper on all Users"
  task :scrape => :environment do
    @users = User.all
    @users.each do |user|
      user.scrape
    end
  end
end
