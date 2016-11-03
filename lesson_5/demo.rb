require 'csv'
require 'ostruct'
require 'date'
require '../lesson_5/moviecollection'
# require '../lesson_5/movie'



movies = MovieCollection.new
movie_class_inst = Movie.new(movies.all.first)

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

# p movie_class_inst.has_genre?('Drama')
# p movie_class_inst.has_genre?('Comedy')

# p movie_class_inst.genre
# p movie_class_inst.actors
# p movie_class_inst.length