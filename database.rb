require 'rubygems'
require 'mongo'

DB_NAME = 'movie-alert' unless Object.const_defined? 'DB_NAME'
DB = Mongo::Connection.new('97.107.138.149').db DB_NAME

Subs = DB.collection 'subs'
Cache = DB.collection 'cache'
Movies = DB.collection 'movies'
Genres = DB.collection 'genres'
Actors = DB.collection 'actors'
Directors = DB.collection 'directors'

Movies.create_index 'genres'
Movies.create_index 'actors'
Movies.create_index 'director'
Movies.create_index 'title'