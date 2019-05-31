every 1.day :at => '05:00pm' do
  rake "users:scrape"
  rake "users:remind"
end
