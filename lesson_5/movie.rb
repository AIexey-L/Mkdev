require 'csv'
require 'ostruct'
require 'date'
require_relative './moviecollection.rb'

class Movie

  attr_accessor :link, :name, :year, :country, :release_date, :genre, :length, :rating, :director, :actors, :film_collection

  def initialize (film)
    film.each { |k,v| instance_variable_set("@#{k}", v) }
  end

  def output
    "#{@link} #{@name} #{@year} #{@country} #{@release_date} #{@genre} #{@length} #{@rating} #{@director} #{@actors}"
  end

  def has_genre? (genre)
    begin
      raise ArgumentError unless @genre_collection.include?(genre)
        @genre.include?(genre)
      rescue ArgumentError
        puts "\n\nWarning! There is no such genre as #{genre}\n\n Available genres are: #{@genre_collection}"
      end
  end
end

