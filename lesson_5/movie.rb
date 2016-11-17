require 'csv'
require 'ostruct'
require 'date'
require_relative './moviecollection.rb'

class InvalidGenreError < StandardError
  attr_reader :wrong_genre
  def initialize(genre)
    @wrong_genre = genre
  end
end

class Movie

  attr_accessor :link, :name, :year, :country, :release_date, :genre, :length, :rating, :director, :actors, :collection, :month

  def initialize (film_collection, film)
    film.each { |k,v| instance_variable_set("@#{k}", v) }
    @collection = film_collection
  end

  def inspect
    format("| %50s | %10s | %12s | %27s | %7s | %3s | %23s | %s", "#{@name}", "#{@release_date}", "#{@country}", "#{@genre}", "#{@length}", "#{@rating}", "#{@director}", "#{@actors}\n")
  end

  def year
    @year = Date.strptime(@release_date, "%Y").strftime("%Y")
  end

  def month
    if @release_date.to_s[6..7] != nil
     @month = Date.strptime(@release_date, "%Y-%m").strftime("%B")
    end
  end

  def has_genre? (genre)
   raise InvalidGenreError.new(genre) unless @collection.genre_exist?(genre)
        @genre.include?(genre)
  end
end


