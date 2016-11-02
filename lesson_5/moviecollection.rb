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
    arr.each { |field| puts "#{field.name} (#{field.release_date}; #{field.country}; #{field.genre}) - #{field.length} "}
  end

  def all
    nice_output(@collection_array)
  end

  def sort_by (for_sorting)
   # @for_sorting = for_sorting
    @sorted = @collection_array.sort_by { |x| x[for_sorting] }
    nice_output(@sorted)
  end

  def filter (field_value)
      @field = field_value.flatten[0]
      @value = field_value.flatten[1]
      @filtered = @collection_array.find_all { |x| x[@field].include?("#{@value}")}
      nice_output(@filtered)
  end

  # method under construction

  def stats(field)
    @stats = @collection_array.find_all { |x| x[field]}.count
    p @stats
  end

end

movies = MovieCollection.new

# working method calls:
# movies.all

# movies.sort_by(:country)
# movies.sort_by(:name)
# movies.sort_by(:release_date)

# movies.filter(genre: 'Comedy')
# movies.filter(country: 'Japan')


# method calls under construction:

movies.stats(:director)
