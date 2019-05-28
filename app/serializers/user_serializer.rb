class UserSerializer < ActiveModel::Serializer
  attributes :id, :gitHubUsername, :photoUrl, :currentStreak, :longestStreak, :totalCommits, :totalGreenDays, :committedToday, :linkedInUrl
end
