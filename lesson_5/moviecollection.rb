require 'csv'
require 'ostruct'
require 'date'
# require '../lesson_5/movie'

FIELDS = %i[ link name year country release_date genre length rating director actors ]

class Movie

  attr_accessor :film

  def initialize (film)
    @film = film
  end

  def actors
    @film[:actors]
  end

  def genre
    @film[:genre]
  end

  def country
    @film[:country]
  end

  def length
    @film[:length]
  end

  def has_genre? (genre)
    unless @film[:genre].include?(genre)
      abort ("Program stopped!!! The GENRE of this movie is not #{genre}")
    end
    true
  end

end

class MovieCollection

  # FIELDS = %i[ link name year country release_date genre length rating director actors ]

  attr_accessor(:filename, :collection_array)

  def initialize(filename = "movies.txt")
    @filename = filename
    unless File.exist?(@filename)
      abort("\n\nTHERE IS NO FILE NAMED: #{filename}, PLEASE, ENTER VALID FILENAME.\nIF NO VALID FILENAME WILL BE ENTERED, PROGRAM WILL BE STARTED\n  WITH DEFAULT FILE: movies.txt\n\n")
    end
    # @collection_array = CSV.foreach(@filename, col_sep: "|", headers: FIELDS).map { |x| OpenStruct.new(x.to_h)}
    @collection_array = CSV.foreach(@filename, col_sep: "|", headers: FIELDS).map { |x| Movie.new(x.to_h)}

  end
  
  
  def nice_output (arr)
    arr.each { |field| puts format("%70s | %10s | %12s | %27s | %7s | %30s", "#{field.film[:name]}", "#{field.film[:release_date]}", "#{field.film[:country]}", "#{field.film[:genre]}", "#{field.film[:length]}", "#{field.film[:actors]}")}

  end


  def all
    # nice_output(@collection_array)
    @collection_array
  end

  def sort_by (for_sorting)
    sorted = @collection_array.sort_by { |x| x.film[for_sorting] }
    # nice_output(sorted)
  end

  # work for one key-value parameter

  # def filter (field_value)
  #     field = field_value.flatten[0]
  #     value = field_value.flatten[1]
  #     filtered = @collection_array.find_all { |x| x[field].include?("#{value}")}
  #     nice_output(filtered)
  # end

  # def filter (field_hash)
  #   i=0
  #   k = field_hash.count
  #   p k
  #   for_filter = @collection_array
  #   while i < k*2
  #     field = field_hash.flatten[ i ]
  #     value = field_hash.flatten[ i + 1 ]
  #     filtered = for_filter.find_all { |x| x[field].include?("#{value}")}
  #     for_filter = filtered
  #     i += 2
  #   end
  #   nice_output(filtered)
  # end

  


  def stats(field)
    if field == :month
      stats = @collection_array.reject { |field| field.film[:release_date].to_s[5..6] == nil }.map { |field| Date.strptime(field.film[:release_date], "%Y-%m").strftime("%B") }.group_by { |x| x }
    elsif field == :year
      stats = @collection_array.map { |field| Date.strptime(field.film[:release_date], "%Y").strftime("%Y") }.group_by { |x| x }
    else
      stats = @collection_array.map { |x| x.film[field].to_s.split(",")}.flatten(1).group_by { |x| x}
    end
    puts stats.each { |k, v| stats[k] = v.count }.sort_by { |k, v| v }.to_h
  end
end

movies = MovieCollection.new

# working method calls:

# p movies.all.first

# p movies.collection_array

# movies.sort_by(:name).first(10)
# movies.sort_by(:release_date).first(10)
# movies.sort_by(:length).first(10)
# movies.sort_by(:release_date).first(10)
# movies.sort_by(:actors).first(10)

# movies.filter(genre: 'Comedy', actors: 'Charles Chaplin')
# movies.filter(genre: 'Biography', actors: 'Robert De Niro')
# movies.filter(country: 'Japan')

# movies.stats(:director)
# movies.stats(:actors)
# movies.stats(:genre)
# movies.stats(:month)
# movies.stats(:year)

movie_class_inst = movies.all.first
#
# p movie_class_inst

# p movie_class_inst.has_genre?('Drama')
# p movie_class_inst.has_genre?('Comedy')
#
# p movie_class_inst.genre
# p movie_class_inst.actors
# p movie_class_inst.length


