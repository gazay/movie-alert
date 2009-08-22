#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'database')

cache = Mongo::Connection.new('97.107.138.149').db('imdb').collection('cache')

cache.remove('name' => 'release_months')

months = Movie.all.to_a.inject([]) { |all, movie|
  if movie.release_date
    all << movie.release_date[0..7]
  else
    all
  end
}.uniq!

p months
