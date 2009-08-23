#!/usr/bin/env ruby

require 'set'
require File.join(File.dirname(__FILE__), '..', 'database')

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

p genres.to_a

#Cache.insert :name => 'release_months', :value => months
#Cache.insert :name => 'directors', :value => directors.to_a
#Cache.insert :name => 'actors', :value => actors.to_a
#Cache.insert :name => 'genres', :value => genres.to_a
