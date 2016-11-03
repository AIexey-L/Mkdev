require 'csv'
require 'ostruct'
require 'date'
require '../lesson_5/moviecollection'

# link name year country release_date genre length rating director actors


class Movie

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
    unless @film.genre.include?(genre)
      abort ("Program stopped!!! The GENRE of this movie is not #{genre}")
    end
    true
  end

end



# movies = MovieCollection.new
#
# movie_class_inst = Movie.new(movies.all.first)
#
# # p movie_class_inst
#
# p movie_class_inst.has_genre?('Drama')
# # p movie_class_inst.has_genre?('Comedy')
# #
# # p movie_class_inst.genre
# # p movie_class_inst.actors
# # p movie_class_inst.length