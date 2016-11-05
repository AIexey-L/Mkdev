require 'csv'
require 'ostruct'
require 'date'
require_relative './moviecollection.rb'

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
