#!/usr/bin/env ruby

require 'rubygems'
require 'mongo'

gem 'porras-imdb'
require 'imdb'

movies = Mongo::Connection.new.db('imdb').collection('movies')

ids_file = ARGV.first

i = 0
j = 0

File.readlines(ids_file).each do |id|
  id = id.strip
  next if id.empty?
  
  movie = ImdbMovie.new(id)
  
  j += 1
  
  next unless movie.director
  
  if movie.plot
    plot = movie.plot.sub(/\s\|$/, '').gsub(/<[^<]+>/, '')
  else
    plot = ''
  end
  
  release_date = nil
  date = movie.release_date
  if date
    release_date = Time.utc(date.year, date.mon, date.mday)
  end
  
  i += 1
  puts "#{j} #{i} #{id} #{movie.title}"
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
