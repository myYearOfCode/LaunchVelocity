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
        client = Twilio::REST::Client.new
        if !user.phone_number == nil
          client.messages.create({
            from: ENV['TWILIO_PHONE_NUMBER'],
            to: user.phone_number,
            body: 'Hey, just reminding you to commit some code to GitHub today! -Mike and Ross'
          })
        end
      end
    end
  end
  desc "Emails Mike to test SendGrid"
  task :testemail => :environment do
    mike = User.where(email: "mikemaven@gmail.com")[0]
    ReminderMailer.new_reminder(mike).deliver_now
    client = Twilio::REST::Client.new
    client.messages.create({
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: '+14019321206',
      body: 'Hey, just reminding you to commit some code to GitHub today! -Mike and Ross'
    })
  end
end
