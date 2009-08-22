#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'database')

Movie.all.each do |movie|
  if movie.release_date.is_a? Time
    movie.release_date = "#{movie.release_date.year}-#{movie.release_date.month}-#{movie.release_date.mday}"
    movie.save
  end
end
