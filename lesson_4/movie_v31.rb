require 'csv'
require 'ostruct'
require 'date'

input = ARGV.first || "movies.txt" # in case of empty filename default file loads

unless File.exist?(input)
  abort("\n\nTHERE IS NO FILE NAMED: #{input}, PLEASE, ENTER VALID FILENAME.\nIF NO VALID FILENAME WILL BE ENTERED, PROGRAM WILL BE STARTED\n  WITH DEFAULT FILE: movies.txt\n\n")
end

# array with names of FIELDS
FIELDS = %i[ link name year country release_date genre length rating director actors ]

array_of_ostructs = CSV.foreach(input, col_sep: "|", headers: FIELDS).map { |x| OpenStruct.new(x.to_h)}


def star_rating (rating) # convert float rating into stars
  "*"*(((rating - 8)*10)+1)
end

def nice_output (arr)
  arr.each { |field| puts "#{field.name} (#{field.release_date}; #{field.genre}) - #{field.length} "}
end

# 5 longest movies don't need to converted  to integer for sorting
arr_five_longest = array_of_ostructs.max_by(5) {|field| field.length.to_i}

# most resent 10 comedies, sort by date (don't need to convert date into integers)
arr_ten_comedies = array_of_ostructs.find_all {|field| field.genre.include?("Comedy")}.max_by(10) {|field| field.release_date}

# make an array of directors sorted by last word (family name)
directors = array_of_ostructs.map(&:director).uniq.sort_by { |field| field.split.last }

# return number of non-USA movies
number_of_nonusa = array_of_ostructs.reject { |field| field.country.include? ("USA")}.count

# pick all dates with revalent months and groups them by months, with names of months
array_dates = array_of_ostructs.reject { |field| field.release_date.to_s[5..6] == nil }.map { |field| Date.strptime(field.release_date, "%Y-%m").strftime("%B") }.group_by { |x| x }

# Output results

puts format("\n\n%30s |  %s", "MONTH:", "Number of movies:")
array_dates.each { |k,v| puts format("%30s |  %s", "#{k}", "#{v.count}")  }

puts "\n\n5 longest movies:\n#{"*"*70}"
nice_output(arr_five_longest)
puts "\n\n10 most recent comedies\n#{"*"*70}"
nice_output(arr_ten_comedies)
puts "\n\nNumber of non-USA movies: #{number_of_nonusa}\n\n"
puts "\n\nList of Directors in alphabetical order\n#{"*"*70}"
directors.each { |x| print "#{x}; "}
puts "\n\n"

