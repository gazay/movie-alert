# require "open-uri"
# 
# years = ['2009','2010','2011','2012']
# 
# years.each do |year|
#   File.open("/Users/alexgaziev/ids#{year}.list", 'w+') do |file|
#     site = open("http://www.imdb.com/List?year=#{year}&&tv=off&&tvm=", 'User-Agent' => 
#     'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.2) Gecko/20090803 Ubuntu/9.04 (jaunty) Shiretoko/3.5.2')
#     # skip = 200
#     #     while site.is_a? Tempfile
#       ids = site.read.scan(/\/title\/tt(\d+)\//)
#       file.puts(ids.map{ |i| i.first }.join("\n"))
# 
#       # site = open("http://www.imdb.com/List?year={year}&&skip=#{skip}", 'User-Agent' => 
#       #         'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.2) Gecko/20090803 Ubuntu/9.04 (jaunty) Shiretoko/3.5.2')
#       #       skip += 200
#     # end
#   end
# end

require "open-uri"

years = ['2009', '2011', '2012']

years.each do |year|
  File.open("/Users/alexgaziev/ids#{year}-2.list", 'w+') do |file|
    site = open("http://www.imdb.com/List?year=#{year}&&tvm=off&&tv=off&&ep=off&&vid=off", 'User-Agent' => 
    'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.2) Gecko/20090803 Ubuntu/9.04 (jaunty) Shiretoko/3.5.2')
    rd = site.read
    all = rd.scan(/Here are the (\d+) matching titles/).first.first.to_i
    puts all
    
    skip = 0
    # while all >= skip
      ids = rd.scan(/\/title\/tt(\d+)\/">[^<]*<\/A><SMALL><\/SMALL>/)
      file.puts(ids.map{ |i| i.first }.join("\n"))
      # skip += 200
      #       puts year + ', skip=' + skip.to_s
      #       site = open("http://www.imdb.com/List?tvm=off&&tv=off&&ep=off&&vid=off&&year=#{year}&&skip=#{skip}", 'User-Agent' => 
      #         'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.2) Gecko/20090803 Ubuntu/9.04 (jaunty) Shiretoko/3.5.2')
      #     end
  end
end
