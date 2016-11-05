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
    hash_array = collection_array.map { |x| x.instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@").to_sym] = x.instance_variable_get(var) }}
  end

  def all
    @collection_array
  end

  def sort_by (for_sorting)
    sorted = hash_array.sort_by { |x| x[for_sorting] }
  end

  def filter (field_hash)
    n = hash_array
     field_hash.each do |k,v|
       m = n.find_all { |x| x[k].include?("#{v}")}
       n = m
     end
     n
  end

  def stats(field)
    if field == :month
      stats = hash_array.reject { |field| field.release_date.to_s[5..6] == nil }.map { |field| Date.strptime(field.release_date, "%Y-%m").strftime("%B") }.group_by { |x| x }
    elsif field == :year
      stats = hash_array.map { |field| Date.strptime(field.release_date, "%Y").strftime("%Y") }.group_by { |x| x }
    else
      stats = hash_array.map { |x| x[field].to_s.split(",")}.flatten(1).group_by { |x| x}
    end
    stats.each { |k, v| stats[k] = v.count }.sort_by { |k, v| v }.to_h
  end
end
