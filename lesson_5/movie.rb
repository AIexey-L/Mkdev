require 'csv'
require 'ostruct'
require 'date'
require_relative './moviecollection.rb'

class InvalidGenreError < StandardError
end

class Movie

  attr_accessor :link, :name, :year, :country, :release_date, :genre, :length, :rating, :director, :actors, :film_collection, :month

  def initialize (film_collection, film)
    film.each { |k,v| instance_variable_set("@#{k}", v) }
    @film_collection = film_collection
  end

  # def inspect
  #   format("| %50s | %10s | %12s | %27s | %7s | %3s | %23s | %s", "#{@name}", "#{@release_date}", "#{@country}", "#{@genre}", "#{@length}", "#{@rating}", "#{@director}", "#{@actors}\n")
  # end

  def year
    @year = Date.strptime(@release_date, "%Y").strftime("%Y")
  end

  def month
    if @release_date.to_s[6..7] != nil
     @month = Date.strptime(@release_date, "%Y-%m").strftime("%B")
    end
  end

  def has_genre? (genre)
   raise InvalidGenreError until @film_collection.collection_array.map  { |x| x.genre.to_s.split(",")}.flatten(1).uniq.include?(genre)
        @genre.include?(genre)
  end
end


