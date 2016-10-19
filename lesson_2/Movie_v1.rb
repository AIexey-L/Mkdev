
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

film_hash = Hash.new(0)
array_of_hashes = []
categories = ["link", "name", "year", "country", "year_of_smth", "genre", "length", "rating", "director", "actors"]
categorized_arr = []

splited.each do |film|
  categorized_arr.push(categories.zip(film))
end

categorized_arr.each do |film|
  array_of_hashes.push(film.to_h)
end

p array_of_hashes
#
# array_of_hashes = Array.new
# x = 0
# film_arr = []
# def array_to_hash (array)
#   if  x < array.length
#     film_arr = array.with_index[x]
#     film_hash[:index] = x
#     film_hash[:link] = film_arr[0]
#     film_hash[:name] = film_arr[1]
#     film_hash[:year] = film_arr[2]
#     film_hash[:country] = film_arr[3]
#     film_hash[:year_of_smth] = film_arr[4]
#     film_hash[:genre] = film_arr[5]
#     film_hash[:length] = film_arr[6]
#     film_hash[:rating] = film_arr[7]
#     film_hash[:director] = film_arr[8]
#     film_hash[:actors] = film_arr[9]
#     array_of_hashes = f
#
#   end
# end


# array_of_hashes(splited)
#
# p array_of_hashes
#
#
# p splited
# def arr_to_h (arr)


# p array_of_hashes
# pfilm_hash
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


# File и String - это классы объектов Ryby. Имеюют встроенные методы.
# Опредеоить коасс любого объекта в Ruby можно методом .class (puts <somthing>.class)
