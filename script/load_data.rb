#!/usr/bin/env ruby

require 'yaml'
require 'set'

require 'config/database'

gem 'porras-imdb'
require 'imdb'

ids_file = ARGV.first
ids = File.readlines(ids_file)

i = 0
j = 0
all = ids.length - 1

ids.each do |id|
  j += 1

  id = id.strip
  next if id.empty?
  next if Movies.find_one('imdb_id' => id)

  movie = ImdbMovie.new(id)
  movie.get_data


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

  release_timestamp = nil
  if movie.release_date
    release_timestamp = if movie.release_date.is_a? String
      Date.parse(movie.release_date).strftime('%s').to_i
    else
      movie.release_date.strftime('%s').to_i
    end
  end

  poster_exists = !movie.poster.nil? and !movie.poster.empty?

  Movies.insert 'imdb_id'           => id,
                'title'             => movie.title,
                'director'          => movie.director,
                'actors'            => movie.cast_members,
                'genres'            => movie.genres,
                'poster'            => movie.poster,
                'poster_exists'     => poster_exists,
                'plot'              => plot,
                'release_date'      => release_date,
                'release_timestamp' => release_timestamp,
                'year'              => movie.year
end
