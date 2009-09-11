def params_to_query(params)
  params.delete('captures')
  params.delete('offset')
  
  params.inject({}) do |query, (key, value)|
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
    query[key] = value
    query
  end
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

def hide_if_ajax
  'hide' if request.xhr?
end

def typographer(string)
  string.gsub(/(^|\s)"/, '\1“').gsub(/"($|\s)/, '”\1').
         gsub(/(\w)'(\w)/, '\1’\2').gsub('...', '…')
end

def trim_actors(actors)
  if 3 < actors.length
    actors[0..2].join(', ') + ', …'
  else
    actors.join(', ')
  end
end

def trim_plot(plot)
  plot.size > 300 ? plot[0..100] + '…' : plot
end

def display_poster(movie)
  if movie['poster_exists']
    url = "http://movie-alert.r09.railsrumble.com/posters/#{movie['imdb_id']}.jpg"
    "<img src='#{url}' alt='Poster for movie #{movie['title']}' class='poster'/>"
  else
    url = "http://movie-alert.r09.railsrumble.com/images/empty.png"
    "<img src='#{url}' alt='No poster found for movie #{movie['title']}' width='150' height='200'/>"
  end
end
