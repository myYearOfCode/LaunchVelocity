namespace :users do
  desc "Runs the scraper on all Users"
  task :scrape => :environment do
    users = User.all
    users.each do |user|
      user.scrape
    end
  end
  desc "Sends a reminder email when a user has not committed in awhile"
  task :remind => :environment do
    users = User.all
    users.each do |user|
      if !user.committedToday
        ReminderMailer.new_reminder(user).deliver_now
      end
    end
  end
end
