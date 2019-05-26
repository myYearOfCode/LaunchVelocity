require 'nokogiri'
require 'open-uri'
require 'pry'

def get_user_graph
    main_url = "https://github.com/myYearOfCode"
    data = data_scraper(main_url)
    graph = data.search(".js-calendar-graph-svg")
    days = graph.search("g").search("g").search("rect")
    commitCount = 0
    longestStreak = 0
    currentStreak = 0
    todaysDate = DateTime.now.to_date
    startDate = Date.strptime("{ 2019-05-22 }", "{ %Y-%m-%d }")
    committedToday = false
    days.each_with_index do |day, index|
      date = Date.strptime("{ #{day["data-date"]} }", "{ %Y-%m-%d }")
      if date < todaysDate && date >= startDate
        numCommits = day["data-count"].to_i
        if numCommits != 0
          commitCount += numCommits
          currentStreak += 1
          if currentStreak > longestStreak
            longestStreak = currentStreak
          end
        else
          if currentStreak > 0
            puts "streak of #{currentStreak} days broken."
          end
          currentStreak = 0
        end
      end
      if date == todaysDate && !numCommits.nil?
        committedToday = true
      end
    end
    display_user_streaks(commitCount, longestStreak, currentStreak, committedToday)
end

def display_user_streaks(commitCount, longestStreak, currentStreak, committedToday)
  puts "#{commitCount} total commits"
  puts "Your current streak is #{currentStreak} days."
  puts "Your longest streak is #{longestStreak} days."
  puts "You have #{committedToday ? "already" : "not"} committed today."
end

def display_user_graph(graph)
    # process node into html somehow
end

def data_scraper(url)
    Nokogiri::HTML(open(url))
end

get_user_graph
