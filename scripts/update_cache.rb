#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'database')

Cache.clear

count = Movies.find.count
i = 0
months = []
Movies.find.each do |movie|
  i += 1
  puts "#{i}/#{count}"
  if movie['release_date']
    months << [movie['release_date'][0..3], movie['release_date'][5..6]]
  end
end
months.uniq!.sort! { |a, b| a[0] + a[1] <=> b[0] + b[1] }


Cache.insert :name => 'release_months', :value => months
