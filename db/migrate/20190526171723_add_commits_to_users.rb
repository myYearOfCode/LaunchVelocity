class AddCommitsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gitHubUsername, :string
    add_column :users, :photoUrl, :string
    add_column :users, :sendReminders, :boolean
    add_column :users, :reminderTime, :time
    add_column :users, :currentStreak, :integer
    add_column :users, :longestStreak, :integer
    add_column :users, :totalCommits, :integer
    add_column :users, :totalGreenDays, :integer
    add_column :users, :committedToday, :boolean
  end
end
