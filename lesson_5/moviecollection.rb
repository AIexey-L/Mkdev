require 'csv'
require 'ostruct'
require 'date'
require_relative './movie.rb'

FIELDS = %i[ link name year country release_date genre length rating director actors genre_collection]

class MovieCollection

  attr_accessor(:filename, :collection_array, :genre_array)

  def initialize(filename = 'movies.txt')
    @filename = filename
    unless File.exist?(@filename)
      abort("\n\nTHERE IS NO FILE NAMED: #{filename}, PLEASE, ENTER VALID FILENAME.\nIF NO VALID FILENAME WILL BE ENTERED, PROGRAM WILL BE STARTED\n  WITH DEFAULT FILE: movies.txt\n\n")
    end
    genre_array = CSV.foreach(@filename, col_sep: "|", headers: FIELDS).map { |x| x[:genre].to_s.split(",")}.flatten(1).uniq
    @collection_array = CSV.foreach(@filename, col_sep: "|", headers: FIELDS).map { |x| Movie.new(x.to_h)}.each { |x| x.instance_variable_set('@genre_collection', genre_array) }
  end

  def all
    @collection_array
  end

  def sort_by (for_sorting)
    sorted = @collection_array.sort_by { |x| x.send(for_sorting) }
  end

  def filter (field_hash)
    n = @collection_array
     field_hash.each do |k,v|
       m = n.find_all { |x| x.send(k).include?("#{v}")}
       n = m
     end
     n
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
