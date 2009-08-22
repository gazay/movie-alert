#!/usr/bin/env ruby

require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'database')

gem 'porras-imdb'
require 'imdb'

all = Movie.all.count

i = 0
Movie.all.each do |movie|
  begin
    data = ImdbMovie.new(movie.imdb_id)
    data.get_data
    i += 1
    puts "#{i}/#{all} #{movie.imdb_id} #{data.title} #{data.year} #{data.release_date}"
    movie.title = data.title
    movie.year = data.year
    movie.release_date = data.release_date
    movie.save
  rescue
    i -= 1
    retry
  end
end
