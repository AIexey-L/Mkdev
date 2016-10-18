
input = ARGV.join # make
filename = "movies.txt"

unless input == "" # in case of empty filename default file loads
  filename = input
end

unless File.exist?(filename) # puts readable comment if file don't exist
  puts "_"*100
  puts "*"*100
  puts " "*100
  puts "THERE IS NO FILE NAMED: #{filename}, PLEASE, ENTER VALID FILENAME OR SKIP ENTERING AND START PROGRAMM."
  puts "IF NO VALID FILENAME WILL BE ENTERED, PROGRAM WILL BE STARTED WITH DEFAULT FILE: movies.txt"
  puts " "*100
  puts "+"*100
  puts "~"*100
end


content = []
IO.foreach(filename) do |line| # IO.foreach reads file per line, less memory usage in case of big fle
   content.push(line.chomp) # make a array of movies
end

splited = []
content.each do |line|
  splited.push(line.to_s.split("|")) # split arrays
end

def star_rating (rating) # convert float rating into stars
  "*"*(((rating - 8)*10)+1)
end

relevant_movies = []
splited.each do |film|
  string = film.join(" ")
  if string.include? ("Time")
    relevant_movies.push([film[1], star_rating(film[7].to_f)]) # make arrays with movie names and ratings
  end
end


puts format("%30s | %s", "Movie", "Rating")
puts "-"*50
relevant_movies.each { |movie| puts format("%30s | %s", "#{movie[0]}", "#{movie[1]}")}


# File и String - это классы объектов Ryby. Имеюют встроенные методы.
# Опредеоить коасс любого объекта в Ruby можно методом .class (puts <somthing>.class)
