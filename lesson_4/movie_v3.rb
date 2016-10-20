
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
categories = [:link, :name, :year, :country, :release_date, :genre, :length, :rating, :director, :actors]
categorized_arr = []
array_of_hashes = []


splited.each do |film| # each film array merges with category names from another array named "categories"
  categorized_arr.push(categories.zip(film))
end

categorized_arr.each do |film| # resulting array with category names converts to array of hashes  with category names as keys
  array_of_hashes.push(film.to_h)
end

# output method for arrays
def nice_output (arr)
  arr.each { |x| puts "#{x[:name]} (#{x[:release_date]}; #{x[:genre]}) - #{x[:length]} "}
end


# 5 longest movies, length converted from "99 min"(string) to 99(integer)
arr_five_longest = array_of_hashes.max_by(5) {|key| key[:length].split(//).map {|x| x[/\d+/]}.compact.join("").to_i}

# 10 comedies, realise date convert from "2010-06-18" (string) to 20100618(integer)
arr_ten_comedies = array_of_hashes.find_all {|key| key[:genre].include?("Comedy")}.max_by(10) {|x| x[:release_date].split(//).map {|x| x[/\d+/]}.compact.join("").to_i}

# make an array of directors sorted by last word (family name)
directors = array_of_hashes.map { |x| x[:director]}.uniq.sort_by { |x| x.split.last }

# return number of non-USA movies
number_of_nonusa = array_of_hashes.reject { |x| x[:country].include? ("USA")}.count


# Output results
puts ""
puts "5 longest movies:"
puts ""
nice_output(arr_five_longest)
puts ""
puts "10 most recent comedies"
puts ""
nice_output(arr_ten_comedies)
puts ""
puts "Number of non-USA movies: #{number_of_nonusa}"
puts ""
puts "List of Directors in alphabetical order"
puts ""
directors.each { |x| print "#{x}; "}


