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
      if user.currentLapse >= 5
        ReminderMailer.new_reminder(user).deliver_now
      end
    end
  end
  desc "Emails Mike to test SendGrid"
  task :testemail => :environment do
    mike = User.where(email: "mikemaven@gmail.com")[0]
    ReminderMailer.new_reminder(mike).deliver_now
  end
end
