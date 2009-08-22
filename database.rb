require 'rubygems'
require 'mongo_record'
require 'fileutils'

MongoRecord::Base.connection = Mongo::Connection.new('97.107.138.149').db('imdb')

Cache = Mongo::Connection.new('97.107.138.149').db('imdb').collection('cache')

class Movie < MongoRecord::Base
  collection_name :movies

  fields :imdb_id, :year, :title, :poster, :plot, :genres, :director, 
         :cast_members, :release_date
  index [:imdb_id, :title, :director, :cast_members, :genres]

  def to_s
    "ID: #{id}, title: #{title}, release: #{release_date}"
  end
end


genres_cache = File.join(File.dirname(__FILE__), '.cache', 'genres.list')
FileUtils.mkdir_p File.dirname(genres_cache)
if File.exists? genres_cache
  Genres = File.readlines(genres_cache)
else
  Genres = Movie.all.inject([]) { |all, i| all + i['genres'] }.uniq!
  File.open(genres_cache, 'w') { |io| io.write Genres.join("\n") }
end

class Subscription < MongoRecord::Base
  collection_name :subscriptions
  
  fields :targets, :emails, :twits
  
  def to_s
    "Target: #{targets.to_a.join('/')}, mails count: #{emails.to_a.size}, twits count: #{twits.to_a.size}"
  end
end
