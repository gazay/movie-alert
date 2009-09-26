#!/usr/bin/env ruby

require 'pathname'
require 'config/database'

posters_dir = (Pathname.new(__FILE__).parent + '../public/posters').expand_path
missing_posters = []

Movies.find('$where' => 'this.poster != null').each do |movie|
  unless posters_dir.join(movie['imdb_id'] + '.jpg').exist?
    missing_posters << movie['imdb_id']
  end
end

puts "\n #{missing_posters.size} posters are missing!"

puts 'Do you want to see which ones?'
if gets[/^y/]
  missing_posters.each do |movie|
    puts movie['imdb_id']
  end
end
