require 'rubygems'
require 'mongo_record'
require 'fileutils'

MongoRecord::Base.connection = Mongo::Connection.new('97.107.138.149').db('movie-alert')
Cache = MongoRecord::Base.connection.collection('cache')

class Movie < MongoRecord::Base
  collection_name :movies

  fields :imdb_id, :year, :title, :poster, :plot, :genres, :director, 
         :cast_members, :release_date
  index [:imdb_id, :title, :director, :cast_members, :genres]
end

class Genre < MongoRecord::Base
  collection_name :genres
  fields :name; index :name, true
end

class Actor < MongoRecord::Base
  collection_name :actors
  fields :name; index :name, true
end

class Director < MongoRecord::Base
  collection_name :directors
  fields :name; index :name, true
end

class Subscription < MongoRecord::Base
  collection_name :subscriptions
  
  fields :targets, :emails, :twits
  
  def to_s
    "Target: #{targets.to_a.join('/')}, mails count: #{emails.to_a.size}, twits count: #{twits.to_a.size}"
  end
end
