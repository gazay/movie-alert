require 'rubygems'
require 'mongo'

DB = Mongo::Connection.new('97.107.138.149').db('movie-alert')

Subs = DB.colleciton 'subs'
Cache = DB.collection 'cache'
Movies = DB.collection 'movies'
Genres = DB.collection 'genres'
Actors = DB.collection 'actors'
Directors = DB.collection 'directors'