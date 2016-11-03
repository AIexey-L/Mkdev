require 'csv'
require 'ostruct'
require 'date'

# FIELDS = %i[ link name year country release_date genre length rating director actors ]


class MovieCollection

  FIELDS = %i[ link name year country release_date genre length rating director actors ]

  attr_accessor(:filename, :collection_array) #:field) # :link, :name, :year, :country, :release_date, :genre, :length, :rating, :director, :actors)

  def initialize(filename = "movies.txt")
    @filename = filename
    unless File.exist?(@filename)
      abort("\n\nTHERE IS NO FILE NAMED: #{filename}, PLEASE, ENTER VALID FILENAME.\nIF NO VALID FILENAME WILL BE ENTERED, PROGRAM WILL BE STARTED\n  WITH DEFAULT FILE: movies.txt\n\n")
    end
    @collection_array = CSV.foreach(@filename, col_sep: "|", headers: FIELDS).map { |x| OpenStruct.new(x.to_h)}
  end
  
  
  def nice_output (arr)
    arr.each { |field| puts format("%70s | %10s | %12s | %27s | %7s | %30s", "#{field.name}", "#{field.release_date}", "#{field.country}", "#{field.genre}", "#{field.length}", "#{field.actors}")}

  end


  def all
    # nice_output(@collection_array)
    @collection_array
  end

  def sort_by (for_sorting)
    sorted = @collection_array.sort_by { |x| x[for_sorting] }
    nice_output(sorted)
  end

  def filter (field_value)
      field = field_value.flatten[0]
      value = field_value.flatten[1]
      filtered = @collection_array.find_all { |x| x[field].include?("#{value}")}
      nice_output(filtered)
  end

  def stats(field)
    if field == :month
      stats = @collection_array.reject { |field| field.release_date.to_s[5..6] == nil }.map { |field| Date.strptime(field.release_date, "%Y-%m").strftime("%B") }.group_by { |x| x }
    elsif field == :year
      stats = @collection_array.map { |field| Date.strptime(field.release_date, "%Y").strftime("%Y") }.group_by { |x| x }
    else
      stats = @collection_array.map { |x| x[field].to_s.split(",")}.flatten(1).group_by { |x| x}
    end
    puts stats.each { |k, v| stats[k] = v.count }.sort_by { |k, v| v }.to_h
  end
end

# movies = MovieCollection.new

# working method calls:

# movies.all

# movies.sort_by(:country)
# movies.sort_by(:name)
# movies.sort_by(:release_date)
# movies.sort_by(:length)
# movies.sort_by(:actors)

# movies.filter(genre: 'Comedy')
# movies.filter(country: 'Japan')

# movies.stats(:director)
# movies.stats(:actors)
# movies.stats(:genre)
# movies.stats(:month)
# movies.stats(:year)


# method calls under construction:


