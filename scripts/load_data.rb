#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '..', 'database')

gem 'porras-imdb'
require 'imdb'

ids_file = ARGV.first
ids = File.readlines(ids_file)

i = 0
j = 0
all = ids.length - 1

ids.each do |id|
  id = id.strip
  next if id.empty?
  
  movie = ImdbMovie.new(id)
  movie.get_data
  
  j += 1
  
  unless movie.director
    puts "#{i}/#{j}/#{all}"
    next
  end
  
  if movie.plot
    plot = movie.plot.sub(/\s\|$/, '').gsub(/<[^<]+>/, '')
  else
    plot = ''
  end
  
  release_date = movie.release_date && movie.release_date.to_s
  
  i += 1
  puts "#{i}/#{j}/#{all} #{id} #{movie.title}"
  puts "    Director: #{movie.director}"
  puts "    Members:  #{movie.cast_members.join(', ')}"
  puts "    Genres:   #{movie.genres.join(', ')}"
  puts "    Poster:   #{movie.poster}"
  puts "    Year:     #{movie.year}"
  puts "    Release:  #{release_date}"
  puts "    Plot:     #{plot}"
  
  genres = movie.genres.map do |i|
    exists = Genres.find_one(:name => i)
    exists ? exists : Genres.insert(:name => i)
  end
  actors = movie.cast_members.map do |i|
    exists = Actors.find_one(:name => i)
    exists ? exists : Genres.insert(:name => i)
  end
  exists = Directors.find_one(:name => movie.director)
  director = exists ? exists : Directors.insert(:name => i)
  
  Movies.insert 'imdb_id'      => id,
                'title'        => movie.title,
                'director'     => director,
                'actors'       => actors,
                'genres'       => genres,
                'poster'       => movie.poster,
                'plot'         => plot,
                'release_date' => release_date,
                'year'         => movie.year
end
