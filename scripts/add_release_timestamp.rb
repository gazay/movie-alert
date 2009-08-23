#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'database')

all = Movies.find.count
i = 0
j = 0
Movies.find.each do |movie|
  i += 1
  if !movie['release_date'].nil? and !movie['release_date'].empty?
    j += 1
    movie['release_timestamp'] = Date.parse(movie['release_date']).
        strftime('%s').to_i
    Movies.save(movie)
  end
  puts "#{j}/#{i}/#{all}"
end
