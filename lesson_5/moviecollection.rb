require 'csv'
require 'ostruct'
require 'date'
require_relative './movie.rb'

FIELDS = %i[ link name year country release_date genre length rating director actors film_collection]

class MovieCollection

  attr_accessor(:filename, :collection_array, :genre_array)

  def initialize(filename = 'movies.txt')
    @filename = filename
    unless File.exist?(@filename)
      abort("\n\nTHERE IS NO FILE NAMED: #{filename}, PLEASE, ENTER VALID FILENAME.\nIF NO VALID FILENAME WILL BE ENTERED, PROGRAM WILL BE STARTED\n  WITH DEFAULT FILE: movies.txt\n\n")
    end
    collection_array_raw = CSV.foreach(@filename, col_sep: "|", headers: FIELDS).map { |x| Movie.new(x.to_h)}
    @collection_array  = collection_array_raw.each { |x| x.film_collection = collection_array_raw }
  end

  def all
    @collection_array
  end

  def sort_by (for_sorting)
    sorted = @collection_array.sort_by(&for_sorting)
  end


  def filter (field_hash)
    field_hash.reduce(@collection_array) { |result, (k, v)| result.find_all {|x| x.send(k).include?(v)}}
  end

  def stats(field)
    if field == :month
      stats = @collection_array.reject { |field| field.release_date.to_s[5..6] == nil }.map { |field| Date.strptime(field.release_date, "%Y-%m").strftime("%B") }.group_by { |x| x }
    elsif field == :year
      stats = @collection_array.map { |field| Date.strptime(field.release_date, "%Y").strftime("%Y") }.group_by { |x| x }
    else
      stats = @collection_array.map { |x| x.send(field).to_s.split(",")}.flatten(1).group_by { |x| x}
    end
    stats.each { |k, v| stats[k] = v.count }.sort_by { |k, v| v }.to_h
  end
end
