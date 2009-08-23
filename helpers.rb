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
    when 'actor'
      value = /#{value}/i
      key = 'actors'
    when 'genre'
      key = 'genres'
    when 'director'
      value = /#{value}/i
    end
    [key, value]
  end]
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

def display_actors(movie)
  string = movie['actors'].join(', ')
  if string.size > 100
    string[0..100] + '...'
  else
    string
  end
end

def display_genres(movie)
  string = movie['genres'].join(', ')
  if string.size > 100
    string[0..100] + '...'
  else
    string
  end
end

def display_plot(movie)
  string = movie['plot']
  if string.size > 300
    string[0..100] + '...'
  else
    string
  end
end

def display_poster(movie)
  if movie['poster_exists']
    url = "http://movie-alert.r09.railsrumble.com/posters/#{movie['imdb_id']}.jpg"
    "<img src='#{url}' alt='Poster for movie #{movie['title']}' class='poster'/>"
  else
    url = "http://movie-alert.r09.railsrumble.com/images/no_cover.png"
    "<img src='#{url}' alt='No poster found for movie #{movie['title']}' width='150' height='200'/>"
  end
  
end