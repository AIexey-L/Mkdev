
input = ARGV.join # make string input (ARGV an array)

input != "" || input = "movies.txt" # in case of empty filename default file loads

File.exist?(input) || abort("\n\nTHERE IS NO FILE NAMED: #{input.to_s}, PLEASE, ENTER VALID FILENAME.\nIF NO VALID FILENAME WILL BE ENTERED, PROGRAM WILL BE STARTED\n  WITH DEFAULT FILE: movies.txt\n\n")

# array with names of FIELDS
FIELDS = %i[ link name year country release_date genre length rating director actors ]
# splitted array of movies, IO.foreach reads file line-by-line processing by block
array_of_hashes = IO.foreach(input).map { |x| FIELDS.zip(x.chomp.to_s.split("|")).to_h}

def star_rating (rating) # convert float rating into stars
  "*"*(((rating - 8)*10)+1)
end

def nice_output (arr)
  arr.each { |x| puts "#{x[:name]} (#{x[:release_date]}; #{x[:genre]}) - #{x[:length]} "}
end

# 5 longest movies don't need to converted  to integer for sorting
arr_five_longest = array_of_hashes.max_by(5) {|key| key[:length].to_i}

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


