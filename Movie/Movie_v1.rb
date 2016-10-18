

content = []
IO.foreach("movies.txt") do |line| # IO.foreach reads file per line, less memory usage in case of big fle
   content.push(line.chomp) # make a array of movies
end

splited = []
content.each do |line|
  splited.push(line.to_s.split("|")) # split arrays
end

def star_rating (rating) # convert float rating into stars
  "*"*((rating - 8)*10)
end

relevant_movies = []
splited.each do |film|
  string = film.join(" ")
  if string.include? ("Time")
    relevant_movies.push([film[1], star_rating(film[7].to_f)])
  end
end


puts format("%30s | %s", "Movie", "Rating")
puts "-"*50
relevant_movies.each { |movie| puts format("%30s | %s", "#{movie[0]}", "#{movie[1]}")}
