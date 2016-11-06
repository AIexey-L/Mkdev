require 'csv'
require 'ostruct'
require 'date'
require_relative './moviecollection.rb'

class Movie

  attr_accessor :link, :name, :year, :country, :release_date, :genre, :length, :rating, :director, :actors, :genre_collection

  def initialize (film)
    film.each { |k,v| instance_variable_set("@#{k}", v) }
  end

  def has_genre? (genre)
      if @genre_collection.include?("#{genre}")
          @genre.include?(genre)
      else
        puts "Warning! There is no such genre as #{genre}"
      end
  end
end

