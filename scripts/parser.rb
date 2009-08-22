require 'mongo'

include Mongo

class Parser
  attr_reader :files, :titles, :coll
  
  def get_files
    @files = []
    Dir.glob('imdb_files/*.list').each {|file| @files << file }
  end
  
  def init_base
    host = ENV['MONGO_RUBY_DRIVER_HOST'] || 'localhost'
    port = ENV['MONGO_RUBY_DRIVER_PORT'] || Mongo::Mongo::DEFAULT_PORT

    puts "Connecting to #{host}:#{port}"
    db = Mongo::Mongo.new(host, port).db('imdb_data')
    @coll = db.collection('titles')
  end
  
  def count
    puts "Count: " + @coll.count.to_s
  end
  
  def find_some(count)
    count.times do |i|
      puts @coll.find(i).inspect
    end
  end
  
  def clear_base
    # Erase all records from collection, if any
    @coll.clear
  end
  
  def get_titles
    File.open('imdb_files/movies.list', 'r') do |infile|
      infile.seek(15)
      infile.lines.each do |line|
        if line.include? '(2009)'
          @coll.insert({'Title' => line.split(' (20')[0], 'Year' => 2009})
        elsif line.include? '(2010)'
          @coll.insert({'Title' => line.split(' (20')[0], 'Year' => 2010})
        elsif line.include? '(2011)'
          @coll.insert({'Title' => line.split(' (20')[0], 'Year' => 2011})
        elsif line.include? '(2012)'      
          @coll.insert({'Title' => line.split(' (20')[0], 'Year' => 2012})
        end
      end
    end
    puts 'Count: ' + @coll.count.to_s
  end
  
  def get_actors
    File.open('./imdb_files/actors.list', 'r') do |infile|
      infile.seek(11514)
      @some = []
      @actors = {}
      infile.lines.count.times do
        s = infile.readline 
        # puts s.inspect
        if s != "\n"
          @some << s
        else
          actor = nil
          # puts @some.inspect
          actor, first = @some[0].split(/\t+/)
          @actors[actor] = [first]
          @some[1..-1].each do |line|
              @actors[actor] << line[3..-1] if line[3..-1].include? '(20'
          end
          @some = []
        end
      end 
      @actors.each do |actor, films|
        films.compact!
        films.each do |film|
          if film.include? '(20'
            ar = film.split(' (20')
            @coll.find('Title' => ar[0]).each do |row|
              row['Actors'] ||= []
              row['Actors'] << actor if !(row['Actors'].include? actor)
              @coll.save(row)
            end
          end
        end
      end
      return
    end
  end
  
  def get_ids
    require "open-uri"

    years = ['2009','2010','2011','2012']

    years.each do |year|
      File.open("/Users/alexgaziev/code/imdb_data/ids/ids#{year}.list", 'w+') do |file|
        site = open("http://www.imdb.com/List?year=#{year}", 'User-Agent' => 
        'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.2) Gecko/20090803 Ubuntu/9.04 (jaunty) Shiretoko/3.5.2')
        skip = 200
        while site.is_a? Tempfile
          ids = site.read.scan(/\/title\/tt(\d+)\//)
          file.puts(ids.map{ |i| i.first }.join("\n"))

          site = open("http://www.imdb.com/List?year=#{year}&&skip=#{skip}", 'User-Agent' => 
            'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.2) Gecko/20090803 Ubuntu/9.04 (jaunty) Shiretoko/3.5.2')
          skip += 200
        end
      end
    end
  end
end