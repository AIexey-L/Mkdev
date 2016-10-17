content = []

IO.foreach("movies.txt") do |line| # IO.foreach reads file per line, less memory usage in case of big fle
   content.push(line.chomp) #
end

splited = []
content.each do |line|
  splited.push(line.to_s.split("|"))
end

# p splited


splited.each { |film| film.shift }

p splited


#lines = []

# File.open("movies.txt") do |content|
#   lines = content.readlines
# end
#
# puts lines [2]