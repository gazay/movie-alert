#!/usr/bin/env ruby

require 'yaml'
require 'set'

DB_NAME = 'fresh-data'

require File.join(File.dirname(__FILE__), '..', 'database')

gem 'porras-imdb'
require 'imdb'

ids_file = ARGV.first
ids = File.readlines(ids_file)

genres = Set.new
actors = Set.new
directors = Set.new

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
    
  genres.merge movie.genres
  actors.merge movie.cast_members
  directors << movie.director

  
  poster_exists = !movie.poster.nil? and !movie.poster.empty?
  
  Movies.insert 'imdb_id'       => id,
                'title'         => movie.title,
                'director'      => movie.director,
                'actors'        => movie.cast_members,
                'genres'        => movie.genres,
                'poster'        => movie.poster,
                'poster_exists' => poster_exists,
                'plot'          => plot,
                'release_date'  => release_date,
                'year'          => movie.year
end

cache_folder = File.join(File.dirname(__FILE__), '..', 'cache')
File.open(File.join(cache_folder, 'directors.yml'), 'w+') {|f| f.puts directors.to_a.to_yaml }
File.open(File.join(cache_folder, 'actors.yml'), 'w+') {|f| f.puts actors.to_a.to_yaml }
File.open(File.join(cache_folder, 'genres.yml'), 'w+') {|f| f.puts genres.to_a.to_yaml }
