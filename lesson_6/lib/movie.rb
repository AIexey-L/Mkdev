require 'csv'
require 'ostruct'
require 'date'
require_relative './moviecollection.rb'

class Movie

  attr_accessor :link, :name, :year, :country, :release_date, :genre, :length, :rating, :director, :actors, :collection, :month, :release_year

  def initialize (film_collection, film)
    film.each { |k,v| instance_variable_set("@#{k}", v) }
    @collection = film_collection
    @genre = @genre.to_s.split(",")
    @actors = @actors.to_s.split(",")
    @release_year = @release_date.to_s[0..3].to_i
  end

  def inspect
    format(" %50s | %10s | %12s | %27s | %7s | %3s | %23s | %s", "#{@name}", "#{@release_date}", "#{@country}", "#{@genre}", "#{@length}", "#{@rating}", "#{@director}", "#{@actors}\n")
  end

  def year
    @release_year
  end

  def month
    if @release_date.to_s[6..7] != nil
     @month = Date.strptime(@release_date, "%Y-%m").strftime("%B")
    end
  end

  def match? (filter_name, filter_value)
    if send(filter_name).is_a?(Array)
      send(filter_name).any? { |val| filter_value ===  val }
    else
      filter_value === send(filter_name)
    end
  end

  def has_genre? (genre)
      raise ArgumentError, "Genre \"#{genre}\" do not exist in collection" unless @collection.genre_exist?(genre)
      @genre.include?(genre)
  end

end

class NewMovie < Movie
  #(2000 по сегодняшний день): 
  #«Название — новинка, вышло N лет назад!
end

class ModernMovie < Movie
  #(1968-2000): «Название — современное кино: 
  #играют Шварценеггер, Шарон Стоун»
end

class ClassicMovie < Movie
  #(1945-1968): «Название — классический фильм, режиссёр такой-то 
  #(ещё 10 его фильмов в спике)»require
end

class AncientMovie < Movie
  #(фильм 1900-1945): «Название — старый фильм (1936 год)»;
end
