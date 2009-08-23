#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'database')

Cache.clear

count = Movies.find.count
i = 0
dates = []
last_year = nil
Movies.find.each do |movie|
  i += 1
  puts "#{i}/#{count}"
  next if movie['title'].nil? or movie['title'] =~ /^\s*$/
  if movie['release_date']
    dates << [movie['release_date'][0..3], movie['release_date'][5..6]]
  end
end
dates.uniq!.sort! { |a, b| a[0] + a[1] <=> b[0] + b[1] }

months = {}
dates.each do |year, month|
  months[year] = [] unless months.has_key? year
  months[year] << month
end

Cache.insert :name => 'release_months', :value => months
