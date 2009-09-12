#!/usr/bin/env ruby

require 'set'
require 'config/database'

Genres.clear
Directors.clear
Actors.clear
Cache.clear

count = Movies.find.count
i = 0
dates = []

genres = Set.new
actors = Set.new
directors = Set.new

last_year = nil
Movies.find.each do |movie|
  i += 1
  puts "#{i}/#{count}"
  next if movie['title'].nil? or movie['title'] =~ /^\s*$/
  if movie['release_date']
    dates << [movie['release_date'][0..3], movie['release_date'][5..6]]
  end
  
  genres.merge movie['genres']
  actors.merge movie['actors']
  directors << movie['director']
end
dates.uniq!.sort! { |a, b| a[0] + a[1] <=> b[0] + b[1] }

months = {}
dates.each do |year, month|
  months[year] = [] unless months.has_key? year
  months[year] << month
end

Cache.insert :name => 'release_months', :value => months

all = genres.length
genres.to_a.each_with_index do |i, j|
  puts "#{j}/#{all}"
  Genres.insert :name => i
end

all = actors.length
actors.to_a.each_with_index do |i, j|
  puts "#{j}/#{all}"
  Actors.insert :name => i
end

all = directors.length
directors.to_a.each_with_index do |i, j|
  puts "#{j}/#{all}"
  Directors.insert :name => i
end
