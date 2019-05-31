require 'rails_helper'
feature 'user gets an email reminder', %Q{
  As a user
  I would like to be reminded when I haven't committed to GitHub
  So I can continue to be held accountable for coding
} do
  scenario 'user has not committed today' do
    ActionMailer::Base.deliveries.clear
    user = FactoryBot.create(:user)

    ReminderMailer.new_reminder(user).deliver_now
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
