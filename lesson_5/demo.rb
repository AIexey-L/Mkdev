require 'csv'
require 'ostruct'
require 'date'
require_relative './moviecollection.rb'
require_relative './movie.rb'


begin
movies = MovieCollection.new


# working method calls for MovieCollection class:

  # p movies.genre_collection.class
# p movies.all.first
# p movies.sort_by(:country).first
# p movies.sort_by(:name).first(10)
# p movies.sort_by(:release_date)
# p movies.sort_by(:length)
# p movies.sort_by(:actors).first(10)

# p movies.filter(genre: 'Comedy')
# p movies.filter(country: 'Japan')
# p movies.filter(genre: 'Comedy', actors: 'Charles Chaplin')
# p movies.filter(genre: 'Biography', actors: 'Robert De Niro')
# p movies.filter(year: 2010..2014)
#  p movies.filter(year: 2013)
# p movies.filter(genre: /(comedy|drama)/i)



# p movies.stats(:director)
# p movies.stats(:actors)
# p movies.stats(:genre)
# p movies.stats(:month)
# p movies.stats(:year)

# working method calls for Movie class

# p movies.all.first.has_genre?('Drama')
# p movies.all.first.has_genre?('Comedy')
# p movies.all.first.has_genre?('Non-existent genre')
# rescue ArgumentError => e
#   p e
#
#
# p movies.all.first.genre
# p movies.all.first.actors
# p movies.all.first.length


end