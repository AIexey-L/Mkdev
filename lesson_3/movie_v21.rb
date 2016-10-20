
input = ARGV.join # make string input (ARGV an array)
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

# splitted array of movies, IO.foreach reads file line-by-line processing by block
splited = IO.foreach(filename).map { |x| x.chomp.to_s.split("|")}

def star_rating (rating) # convert float rating into stars
  "*"*(((rating - 8)*10)+1)
end

# array with names of fields
fields = [:link, :name, :year, :country, :release_date, :genre, :length, :rating, :director, :actors]

# convert array of arrays into array of hashes with key names from fields array
array_of_hashes = splited.map { |x| fields.zip(x).to_h}

# output method for arrays
def nice_output (arr)
  arr.each { |x| puts "#{x[:name]} (#{x[:release_date]}; #{x[:genre]}) - #{x[:length]} "}
end

# 5 longest movies, length converted from "99 min"(string) to 99(integer)
arr_five_longest = array_of_hashes.max_by(5) {|key| key[:length].split(//).map {|x| x[/\d+/]}.compact.join("").to_i}

# most resent 10 comedies, sort by date (don't need to convert date into integers)
arr_ten_comedies = array_of_hashes.find_all {|key| key[:genre].include?("Comedy")}.max_by(10) {|x| x[:release_date]}

# make an array of directors sorted by last word (family name)
directors = array_of_hashes.map { |x| x[:director]}.uniq.sort_by { |x| x.split.last }

# return number of non-USA movies
number_of_nonusa = array_of_hashes.reject { |x| x[:country].include? ("USA")}.count

# Output results
puts "\n\n5 longest movies:\n#{"*"*70}"
nice_output(arr_five_longest)
puts "\n\n10 most recent comedies\n#{"*"*70}"
nice_output(arr_ten_comedies)
puts "\n\nNumber of non-USA movies: #{number_of_nonusa}\n\n"
puts "\n\nList of Directors in alphabetical order\n#{"*"*70}"
directors.each { |x| print "#{x}; "}
puts "\n\n"


