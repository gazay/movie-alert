require "rubygems"
gem('twitter4r', '0.3.1')
require 'twitter'

module Twit
  attr_reader :twitter

  def connect
    @twitter = Twitter::Client.from_config('files/twit_credentials.yml')
  end

  def send_message(message, user=nil, users=[])
    twitter.message(:post, message, user) if user
    users.each do |usr|
      twitter.message(:post, message, usr) if usr
    end
  end
end