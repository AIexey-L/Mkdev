require 'csv'
require 'ostruct'
require 'date'
require_relative './moviecollection.rb'
require_relative './movie.rb'



movies = MovieCollection.new
movie_class_inst = Movie.new(movies.all.first)

# working method calls for MovieCollection class:

# p movies.all

# p movies.sort_by(:country).first(10)
# p movies.sort_by(:name).first(10)
# p movies.sort_by(:release_date).first(10)
# p movies.sort_by(:length).first(10)
# p movies.sort_by(:actors).first(10)

# p movies.filter(genre: 'Comedy')
# p movies.filter(country: 'Japan')
# p movies.filter(genre: 'Comedy', actors: 'Charles Chaplin')
# p movies.filter(genre: 'Biography', actors: 'Robert De Niro')

# p movies.stats(:director)
# p movies.stats(:actors)
# p movies.stats(:genre)
# p movies.stats(:month)
# p movies.stats(:year)

# working method calls for Movie class

# p movie_class_inst.has_genre?('Drama')
# p movie_class_inst.has_genre?('Comedy')


# p movie_class_inst.genre
# p movie_class_inst.actors
# p movie_class_inst.length

# p movie_class_inst

# p movie_class_inst.film