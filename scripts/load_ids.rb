require "open-uri"

years = ['2009','2010','2011','2012']

years.each do |year|
  File.open("/Users/username/code/imdb_data/ids/ids{year}.list", 'w+') do |file|
    site = open("http://www.imdb.com/List?year={year}", 'User-Agent' => 
    'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.2) Gecko/20090803 Ubuntu/9.04 (jaunty) Shiretoko/3.5.2')
    skip = 200
    while site.is_a? Tempfile
      ids = site.read.scan(/\/title\/tt(\d+)\//)
      file.puts(ids.map{ |i| i.first }.join("\n"))

      site = open("http://www.imdb.com/List?year={year}&&skip=#{skip}", 'User-Agent' => 
        'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.2) Gecko/20090803 Ubuntu/9.04 (jaunty) Shiretoko/3.5.2')
      skip += 200
    end
  end
end
