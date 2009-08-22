#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'database')

Cache.clear

count = Movies.find.count
i = 0
months = []
Movies.find.each do |movie|
  i += 1
  puts "#{i}/#{count}"
  months << [movie['release_date'][0..6]] if movie['release_date']
end
months.uniq!.sort!


Cache.insert :name => 'release_month', :value => months
