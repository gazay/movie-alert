require "database"
require 'twitter'
require 'pony'

tomorow = Movies.find(:release_date => (Date.today).to_s).to_a
next_week = Movies.find(:release_date => (Date.today + 7).to_s).to_a

def replace_mongo_objects(movies)
  movies.each do |movie|
    puts movie.inspect
    puts movie['actors'].count
    movie['actors'].each do |actor|
      puts actor.to_s
    end
  end
end
puts (Date.today + 1).to_s
replace_mongo_objects tomorow

module Notifications
  extend self
  
  def send_twit(message, user=nil, users=[])
    twitter = Twitter::Client.from_config('files/twit_credentials.yml')
    twitter.message(:post, message, user) if user
    users.each do |usr|
      twitter.message(:post, message, usr) if usr
    end
  end
  
  def send_mail(to, subj, body)
    Pony.mail(:to => to, :via => :smtp, :smtp => {
        :host   => 'smtp.gmail.com',
        :port   => '465',
        :user   => 'mov.alert',
        :pass   => '13579qetuo',
        :auth   => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain => "localhost.localdomain" # the HELO domain provided by the client to the server
      }, :subject => subj, :body => body)
  end
end