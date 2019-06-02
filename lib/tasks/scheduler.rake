desc "Runs the scraper on all Users"
task :scrape => :environment do
  users = User.all
  puts "Scraping all users."
  users.each do |user|
    user.scrape
  end
  puts "Finished scraping all users."
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
