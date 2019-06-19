require 'nokogiri'
require 'open-uri'
require 'json'

class User < ApplicationRecord
  def getTitle
    main_url = self.linkedInUrl
    puts main_url
    user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"

    data = Nokogiri::HTML(open(main_url, "User-Agent" => user_agent, "Accept-Encoding" => "gzip, deflate"))
    # graph = data.search(".js-calendar-graph-svg")
    title = data.search("h2").search(".mt-1")
    puts title
  end

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
    user_badges = {}
    badges = {1=>"first commit", 5=>"5 days", 7=>"one week", 14=>"two weeks", 25=>"25 days", 50=>"50 days"}

    days.each_with_index do |day, index|
      date = Date.strptime("{ #{day["data-date"]} }", "{ %Y-%m-%d }")
      if date < todaysDate && date >= startDate
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
        if badges[currentStreak]
          user_badges[currentStreak] = badges[currentStreak]
        end
      end
      if date == todaysDate && date >= startDate
        numCommits = day["data-count"].to_i
        if numCommits == 0
          currentLapse += 1
        end
      end
      if date == todaysDate && day["data-count"].to_i > 0
        committedToday = true
      end
    end
    photoUrl = scrape_profile_pic(data)
    self.update(totalCommits: totalCommits, longestStreak: longestStreak, currentStreak: currentStreak, currentLapse: currentLapse, committedToday: committedToday, totalGreenDays: totalGreenDays, photoUrl: photoUrl, user_badges: user_badges.to_json, graph: graph)
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
