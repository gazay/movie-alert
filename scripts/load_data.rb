#!/usr/bin/env ruby

require 'rubygems'
require 'mongo'

gem 'porras-imdb'
require 'imdb'

movies = Mongo::Connection.new.db('imdb').collection('movies')

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
  puts "  #{movie.director}"
  puts "  #{movie.cast_members.join(', ')}"
  puts "  #{movie.genres.join(', ')}"
  puts "  #{movie.poster}"
  puts "  #{plot}"
  puts "  #{release_date}"
  
  movies.insert('imdb_id'      => id,
                'title'        => movie.title,
                'director'     => movie.director,
                'cast_members' => movie.cast_members,
                'genres'       => movie.genres,
                'poster'       => movie.poster,
                'plot'         => plot,
                'release_date' => release_date)
end
