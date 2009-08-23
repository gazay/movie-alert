def params_to_query(params)
  params.delete('captures')
  params.delete('offset')
  
  Hash[params.to_a.map do |key, value|
    case key
    when 'year'
      value = value.to_i
    when 'release_date'
      value = /^#{value}/
    when 'title'
      value = /#{value}/i
    when 'genre'
      entry = Genres.find_one(:name => value)
      value = entry
      key = 'genres'
    when 'actor'
      entry = Actors.find_one(:name => /#{value}/i)
      value = entry
      key = 'actors'
    when 'director'
      entry = Directors.find_one(:name => /#{value}/i)
      value = entry
    end
    [key, value]
  end]
end

def poster_thumb(poster_url, width, height)
  poster_url[0..-5] + "._V1._SX#{width}_SY#{height}_.jpg"
end

def format_date(date, year)
  date = Date.parse(date)
  
  day = if (11..13).include?(date.mday % 100)
    "#{date.mday}th"
  else
    case date.mday % 10
    when 1; "#{date.mday}st"
    when 2; "#{date.mday}nd"
    when 3; "#{date.mday}rd"
    else "#{date.mday}th"
    end
  end
  
  if year
    date.strftime("#{day} of %B, %Y")
  else
    date.strftime("#{day} of %B")
  end
end

def hide_if_part(format)
  'part' == format ? 'hide' : ''
end

def typographer(string)
  string.gsub(/(^|\s)"/, '\1“').gsub(/"($|\s)/, '”\1').
         gsub(/(\w)'(\w)/, '\1’\2').gsub('...', '…')
end