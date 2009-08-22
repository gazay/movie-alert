require 'mongo_record'

MongoRecord::Base.connection = Mongo::Connection.new.db('imdb_data')

class Movie < MongoRecord::Base
  collection_name :movies

  fields :year, :title, :poster, :plot, :genres, :director, :cast_members
  index :title
  
  def to_s
    "ID: #{id}, title: #{title}, year: #{year}"
  end
end

Genres = Movie.all.inject([]) { |all, i| all + i['genres'] }.uniq!