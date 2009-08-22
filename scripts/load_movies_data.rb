#!/usr/bin/env ruby

require 'rubygems'
require 'mongo'
require 'imdb'

host = ENV['MONGO_RUBY_DRIVER_HOST'] || 'localhost'
port = ENV['MONGO_RUBY_DRIVER_PORT'] || XGen::Mongo::Driver::Mongo::DEFAULT_PORT
movies = XGen::Mongo::Driver::Mongo.new(host, port).db('imdb_data').collection('movies')

ids_file = ARGV.first

i = 0
j = 0

File.readlines(ids_file).each do |id|
  id = id.strip
  next if id.empty?
  
  movie = Imdb::Movie.new(id)
  
  j += 1
  
  next if movie.director.empty?
  
  i += 1
  puts "#{j} #{i} #{id} #{movie.title}"
  puts "  #{movie.director.join(', ')}"
  puts "  #{movie.cast_members.join(', ')}"
  puts "  #{movie.genres.join(', ')}"
  puts "  #{movie.poster}"
  puts "  #{movie.plot}"
  puts "  #{movie.year}"
  
  movies.insert('id'           => id,
                'title'        => movie.title,
                'director'     => movie.director,
                'cast_members' => movie.cast_members,
                'genres'       => movie.genres,
                'poster'       => movie.poster,
                'plot'         => movie.plot,
                'year'         => movie.year)
end
