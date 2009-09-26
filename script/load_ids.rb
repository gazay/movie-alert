#!/usr/bin/env ruby

require "open-uri"

YEARS = [2009, 2010, 2011, 2012, 2013]
AGENT = 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.2) Gecko/20090803 ' +
        'Ubuntu/9.04 (jaunty) Shiretoko/3.5.2'
QUERY = '&&tvm=off&&tv=off&&ep=off&&vid=off'

YEARS.reverse.each do |year|
  File.open("ids#{year}.list", 'w+') do |file|
    page = open("http://www.imdb.com/List?year=#{year}#{QUERY}",
                'User-Agent' => AGENT).read
    
    all = page.scan(/Here are the (\d+) matching titles/).first.first.to_i
    puts "#{year} #{all}"
    
    (0..all).step(200) do |skip|
      puts "#{year} skip #{skip}"
      page = open("http://www.imdb.com/List?year=#{year}&&skip=#{skip}#{QUERY}",
                  'User-Agent' => AGENT).read
      ids = page.scan(/\/title\/tt(\d+)\/">[^<]*<\/A><SMALL><\/SMALL>/)
      file.puts(ids.map{ |i| i.first }.join("\n"))
    end
  end
end
