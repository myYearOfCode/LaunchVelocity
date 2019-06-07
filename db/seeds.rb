# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
github =  ["kemmerle", "andxhav", "Andrew-Randall", "Anthonyhelka", "BorisMargarian", "dc-anthony", "Hurlyburly2", "baker914", "ericfrancis313", "HGarcia22",  "jwinnfeild2517", "joeSzaf", "JoshuaTPereira", "kmsrankin", "IndayLi", "MikeMaven", "mwellman17", "nkim1225", "paigiethefriendlydragon",  "KingDad", "rokarim", "myYearOfCode", "sromelus", "Tasneem52", "jarmstro0", "Jtenore", "CaseyCHannan"]

linkedIn = [ "https://www.linkedin.com/in/allison-kemmerle/", "https://www.linkedin.com/in/andrewhaveles/", "https://www.linkedin.com/in/a-randall/", "https://www.linkedin.com/in/anthonyhelka/", "https://www.linkedin.com/in/boris-margarian/", "https://www.linkedin.com/in/dc-anthony/", "https://www.linkedin.com/in/douglas-simon/", "https://www.linkedin.com/in/cd-baker/", "https://www.linkedin.com/in/ericfrancis313/", "https://www.linkedin.com/in/heathergarcia11", "https://www.linkedin.com/in/jenner-thomas/", "https://www.linkedin.com/in/joeszaf/", "https://www.linkedin.com/in/joshua-t-pereira/", "https://www.linkedin.com/in/keegan-rankin/", "https://www.linkedin.com/in/leonamarzinotto/", "https://www.linkedin.com/in/mikemaven/", "https://www.linkedin.com/in/michaelwellman/", "https://www.linkedin.com/in/nicholasjinsookim/", "https://www.linkedin.com/in/paige-kiefner/", "https://www.linkedin.com/in/petergrcarlson/", "https://www.linkedin.com/in/rominakarim/", "https://www.linkedin.com/in/rossdaly/", "https://www.linkedin.com/in/shardlyromelus/", "https://www.linkedin.com/in/tasneem-amreliwala/", "https://www.linkedin.com/in/johnkarmstrong/","https://www.linkedin.com/in/josephtenore/", "https://www.linkedin.com/in/caseyhannan/" ]

github.each_with_index do |person, index|
  User.create({email: "#{github[index]}@launchvelocity.com", gitHubUsername: github[index], password: github[index], linkedInUrl: linkedIn[index]})
end
