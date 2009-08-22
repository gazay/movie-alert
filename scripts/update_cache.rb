#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'database')

Cache.drop

months = Movie.all.to_a.inject([]) { |all, movie|
  if movie.release_date
    all << movie.release_date[0..7]
  else
    all
  end
}.uniq!

p months

#Cache.insert 'release_month' => month
