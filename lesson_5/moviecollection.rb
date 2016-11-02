require 'csv'
require 'ostruct'
require 'date'


FIELDS = %i[ link name year country release_date genre length rating director actors ]

class MovieCollection

  attr_accessor(:filename, :collection_array) #:field) # :link, :name, :year, :country, :release_date, :genre, :length, :rating, :director, :actors)

  def initialize(filename = "movies.txt")
    @filename = filename
    unless File.exist?(@filename)
      abort("\n\nTHERE IS NO FILE NAMED: #{filename}, PLEASE, ENTER VALID FILENAME.\nIF NO VALID FILENAME WILL BE ENTERED, PROGRAM WILL BE STARTED\n  WITH DEFAULT FILE: movies.txt\n\n")
    end
    @collection_array = CSV.foreach(@filename, col_sep: "|", headers: FIELDS).map { |x| OpenStruct.new(x.to_h)}
  end
  
  
  def nice_output (arr)
    arr.each { |field| puts "#{field.name} (#{field.release_date}; #{field.genre}) - #{field.length} "}
  end

  def all
    nice_output(@collection_array)
  end

  # methods under construction

  # def sort_by (field)
  #  nice_output(@collection_array.sort_by { |field| field})
  # end

  # def filter (field, value)
  #   nice_output(@collection_array.find_all { |field| field.include?("#{value}")})
  end

end

movies = MovieCollection.new

# working methods:
# movies.all



# methods under construction:
#movies.sort_by(:release_date)

#movies.filter(:country, "USA")