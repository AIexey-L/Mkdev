require 'csv'
require 'ostruct'
require 'date'
require_relative './moviecollection.rb'

class Movie

  attr_accessor :link, :name, :year, :country, :release_date, :genre, :length, :rating, :director, :actors

  def initialize (film)
    film.each { |k,v| instance_variable_set("@#{k}", v) }
  end

  def has_genre? (genre)
    unless @genre.include?(genre)
      abort ("Program stopped!!! The GENRE of this movie is not #{genre}")
    end
    true
  end
end

