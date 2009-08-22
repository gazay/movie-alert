#!/usr/bin/env ruby

require 'rubygems'
require 'database'
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
  
  next unless movie.director
  
  if movie.plot
    plot = movie.plot.sub(/\s\|$/, '').gsub(/<[^<]+>/, '')
  else
    plot = ''
  end
  
  release_date = nil
  date = movie.release_date
  release_date.to_s if date
  
  i += 1
  puts "#{j}/#{all} #{i} #{id} #{movie.title}"
  puts "  Director: #{movie.director}"
  puts "  Members:  #{movie.cast_members.join(', ')}"
  puts "  Genres:   #{movie.genres.join(', ')}"
  puts "  Poster:   #{movie.poster}"
  puts "  Year:     #{year}"
  puts "  Release:  #{release_date}"
  puts "  Plot:     #{plot}"
  
  genres = movie.genres.map {|it| Genre.create :name => it }
  actors = movie.cast_members.map {|it| Actor.create :name => it }  
  director = Director.create :name => movie.director
  
  Movie.create 'imdb_id'      => id,
               'title'        => movie.title,
               'director'     => director,
               'actors'       => actors,
               'genres'       => genres,
               'poster'       => movie.poster,
               'plot'         => plot,
               'release_date' => release_date
end