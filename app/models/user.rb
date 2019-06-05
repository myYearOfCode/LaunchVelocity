require 'nokogiri'
require 'open-uri'

class User < ApplicationRecord
  def scrape
    main_url = "https://github.com/#{self.gitHubUsername}"
    data = Nokogiri::HTML(open(main_url))
    graph = data.search(".js-calendar-graph-svg")
    days = graph.search("g").search("g").search("rect")
    totalCommits = 0
    longestStreak = self.longestStreak || 0
    currentStreak = 0
    totalGreenDays = 0
    currentLapse = 0
    todaysDate = Date.strptime(DateTime.now.in_time_zone("Eastern Time (US & Canada)").strftime("%Y-%m-%d"), "%Y-%m-%d")
    startDate = Date.strptime("{ 2019-05-22 }", "{ %Y-%m-%d }")
    committedToday = false
    # Time.now
    days.each_with_index do |day, index|
      date = Date.strptime("{ #{day["data-date"]} }", "{ %Y-%m-%d }")
      if date <= todaysDate && date >= startDate
        numCommits = day["data-count"].to_i
        if numCommits > 0
          totalGreenDays += 1
          totalCommits += numCommits
          currentStreak += 1
          currentLapse = 0
          if currentStreak > longestStreak
            longestStreak = currentStreak
          end
        else
          currentStreak = 0
          currentLapse += 1
        end
      end
      if date == todaysDate && day["data-count"].to_i > 0
        committedToday = true
      end
    end
    photoUrl = scrape_profile_pic(data)
    self.update(totalCommits: totalCommits, longestStreak: longestStreak, currentStreak: currentStreak, currentLapse: currentLapse, committedToday: committedToday, totalGreenDays: totalGreenDays, photoUrl: photoUrl, graph: graph)
  end

  def scrape_profile_pic(data)
    profile_url = data.search("img").search(".avatar").search(".height-full")[0]["src"]
    profile_url
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
