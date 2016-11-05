require 'csv'
require 'ostruct'
require 'date'
require_relative './movie.rb'

FIELDS = %i[ link name year country release_date genre length rating director actors ]

class MovieCollection

  attr_accessor(:filename, :collection_array)

  def initialize(filename = 'movies.txt')
    @filename = filename
    unless File.exist?(@filename)
      abort("\n\nTHERE IS NO FILE NAMED: #{filename}, PLEASE, ENTER VALID FILENAME.\nIF NO VALID FILENAME WILL BE ENTERED, PROGRAM WILL BE STARTED\n  WITH DEFAULT FILE: movies.txt\n\n")
    end
    @collection_array = CSV.foreach(@filename, col_sep: "|", headers: FIELDS).map { |x| Movie.new(x.to_h)}
  end
  
  def nice_output (arr)
    arr.each { |field| puts format("%70s | %10s | %12s | %27s | %7s | %30s", "#{field.film[:name]}", "#{field.film[:release_date]}", "#{field.film[:country]}", "#{field.film[:genre]}", "#{field.film[:length]}", "#{field.film[:actors]}")}
  end

  def all
    @collection_array
  end

  def sort_by (for_sorting)
    sorted = @collection_array.sort_by { |x| x.film[for_sorting] }
  end

  def filter (field_hash)
    @n = @collection_array
     field_hash.each do |k,v|
       m = @n.find_all { |x| x.film[k].include?("#{v}")}
       @n = m
     end
     @n
  end

  def stats(field)
    if field == :month
      stats = @collection_array.reject { |field| field.film[:release_date].to_s[5..6] == nil }.map { |field| Date.strptime(field.film[:release_date], "%Y-%m").strftime("%B") }.group_by { |x| x }
    elsif field == :year
      stats = @collection_array.map { |field| Date.strptime(field.film[:release_date], "%Y").strftime("%Y") }.group_by { |x| x }
    else
      stats = @collection_array.map { |x| x.film[field].to_s.split(",")}.flatten(1).group_by { |x| x}
    end
    stats.each { |k, v| stats[k] = v.count }.sort_by { |k, v| v }.to_h
  end
end
