require 'eventmachine'
require 'neverblock'
require 'net/http'
require 'config/database'

def poster_thumb(poster_url, width=150, height=200)
  poster_url[0..-5] + "._V1._SX#{width}_SY#{height}_.jpg"
end

def get_poster(thumb, path, id)  
  response = Net::HTTP.get_response(URI.parse thumb)
  puts "#{id} -- #{response['content-type']} -- #{response.code}"
  if response.code == '200'
    File.open(path, 'wb+') {|f| f.write response.body }
    :success
  end
end

posters_directory = File.expand_path(File.join File.dirname(__FILE__), '../public/posters')


EM.run do
  Pool = NB::Pool::FiberPool.new(50)
  
  Movies.find('$where' => 'this.poster != null').each do |movie|
    Pool.spawn do
      thumb =  poster_thumb(movie['poster'])
      id = movie['imdb_id']
      poster_path = File.join(posters_directory, "#{id}.jpg")
    
      loop { break if get_poster(thumb, poster_path, id) == :success }
    end
  end

  break
end