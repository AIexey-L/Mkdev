
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

# array with names of categories
categories = [:link, :name, :year, :country, :year_of_smth, :genre, :length, :rating, :director, :actors]
categorized_arr = []
array_of_hashes = []


splited.each do |film| # each film array merges with category names from another array named "categories"
  categorized_arr.push(categories.zip(film))
end

categorized_arr.each do |film| # resulting array with category names converts to array of hashes  with category names as keys
  array_of_hashes.push(film.to_h)
end

# p array_of_hashes

# array_of_hashes.each

# x=0

# array_of_hashes.

arr_five_longest = array_of_hashes.max_by(5) {|key| key[:length].split(//).map {|x| x[/\d+/]}.compact.join("").to_i}

p arr_five_longest

# def five_longest (arr)
#   while x < 5
#     arr.select()
#   end
# end

# p array_of_hashes
# p film_hash
#
# relevant_movies = []
# splited.each do |film| # pick relevant movie(s) with certain criteria
#   string = film.join(" ")
#   if string.include? ("Time")
#     relevant_movies.push([film[1], star_rating(film[7].to_f)]) # make arrays with movie names and ratings
#   end
# end
#
#
# puts format("%30s | %s", "Movie", "Rating")
# puts "-"*50
# relevant_movies.each { |movie| puts format("%30s | %s", "#{movie[0]}", "#{movie[1]}")}
#
#
# File и String - это классы объектов Ryby. Имеюют встроенные методы.
# Опредеоить коасс любого объекта в Ruby можно методом .class (puts <somthing>.class)
