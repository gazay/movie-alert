require 'mongo_record'

MongoRecord::Base.connection = Mongo::Connection.new('97.107.138.149').db('imdb_data')

class Movie < MongoRecord::Base
  collection_name :movies

  fields :year, :title, :poster, :plot, :genres, :director, :cast_members
  index [:title, :director, :cast_members, :genres]

  def to_s
    "ID: #{id}, title: #{title}, year: #{year}"
  end
end

Genres = Movie.all.inject([]) { |all, i| all + i['genres'] }.uniq!

class Subscription < MongoRecord::Base
  collection_name :subscriptions
  
  fields :sub_targets, :emails, :twits
  
  def to_s
    "Target: #{sub_targets.to_a.join('/')}, mails count: #{emails.to_a.size}, twits count: #{twits.to_a.size}"
  end
end