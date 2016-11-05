require 'csv'
require 'ostruct'
require 'date'
require_relative './movie.rb'

FIELDS = %i[ link name year country release_date genre length rating director actors ]

# class Movie
#
#   attr_accessor :film
#
#   def initialize (film)
#     @film = film
#   end
#
#   def actors
#     @film[:actors]
#   end
#
#   def genre
#     @film[:genre]
#   end
#
#   def country
#     @film[:country]
#   end
#
#   def length
#     @film[:length]
#   end
#
#   def has_genre? (genre)
#     unless @film[:genre].include?(genre)
#       abort ("Program stopped!!! The GENRE of this movie is not #{genre}")
#     end
#     true
#   end
#
# end

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


  def filter (field_hash)
    @n = @collection_array
     field_hash.each do |k,v|
       m = @n.find_all { |x| x.film[k].include?("#{v}")}
       @n = m
     end
     @n
  end


  def stats(field)
    if field == :month
      stats = @collection_array.reject { |field| field.film[:release_date].to_s[5..6] == nil }.map { |field| Date.strptime(field.film[:release_date], "%Y-%m").strftime("%B") }.group_by { |x| x }
    elsif field == :year
      stats = @collection_array.map { |field| Date.strptime(field.film[:release_date], "%Y").strftime("%Y") }.group_by { |x| x }
    else
      stats = @collection_array.map { |x| x.film[field].to_s.split(",")}.flatten(1).group_by { |x| x}
    end
    stats.each { |k, v| stats[k] = v.count }.sort_by { |k, v| v }.to_h
  end
end

# movies = MovieCollection.new

# working method calls:

# p movies.all
# p movies.all.first

# p movies.collection_array

 # movies.sort_by(:name).first(10)
# p movies.sort_by(:release_date).first(10)
# movies.sort_by(:length).first(10)
# movies.sort_by(:release_date).first(10)
# movies.sort_by(:actors).first(10)

# movies.filter(genre: 'Biography')

# movies.filter(genre: 'Comedy', actors: 'Charles Chaplin')
# p movies.filter(genre: 'Biography', actors: 'Robert De Niro')
# movies.filter(country: 'Japan')

# movies.stats(:director)
# movies.stats(:actors)
# movies.stats(:genre)
# movies.stats(:month)
# movies.stats(:year)

# movie_class_inst = movies.all.first
#
# p movie_class_inst

# p movie_class_inst.has_genre?('Drama')
# p movie_class_inst.has_genre?('Comedy')
#
# p movie_class_inst.genre
# p movie_class_inst.actors
# p movie_class_inst.length


