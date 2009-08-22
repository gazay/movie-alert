require 'mongo_record'

MongoRecord::Base.connection = Mongo::Connection.new('97.107.138.149').db('imdb')

class Movie < MongoRecord::Base
  collection_name :movies

  fields :imdb_id, :year, :title, :poster, :plot, :genres, :director, 
         :cast_members
  index [:imdb_id, :title, :director, :cast_members, :genres]

  def to_s
    "ID: #{id}, title: #{title}, year: #{year}"
  end
end

Genres = Movie.all.inject([]) { |all, i| all + i['genres'] }.uniq!

class Subscription < MongoRecord::Base
  collection_name :subscriptions
  
  fields :targets, :emails, :twits
  
  def to_s
    "Target: #{targets.to_a.join('/')}, mails count: #{emails.to_a.size}, twits count: #{twits.to_a.size}"
  end
end
