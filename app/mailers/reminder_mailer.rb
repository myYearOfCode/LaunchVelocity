class ReminderMailer < ApplicationMailer
  def new_reminder(user)
    @user = user

    mail(
      to: user.email
      subject: "A reminder to Git!"
    )
  end
end
