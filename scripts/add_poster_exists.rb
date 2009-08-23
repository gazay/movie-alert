#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'database')

all = Movies.find.count
i = 0

Movies.find.each do |movie|
  i += 1
  puts "#{i}/#{all}"
  movie['poster_exists'] = !movie['poster'].nil? and !movie['poster'].empty?
  Movies.save(movie)
end
