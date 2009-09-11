module Base
  if Sinatra::Application.environment == :production
    def bundle
      include_links + tag_for_file('application_compressed')
    end
  else
    def bundle
      include_links + include_files
    end
  end # Sinatra::Application.environment == :production

  protected

  def sources
    raise 'Abstract method'
  end

  def tag(url)
    raise 'Abstract method'
  end

  def full_path(file)
    raise 'Abstract method'
  end

  def links
    sources.select {|it| it[/^http/] }
  end

  def include_links
    links.map {|it| tag it }.join
  end

  def files
    sources - links
  end

  def tag_for_file(name)
    tag full_path(name)
  end

  def include_files
    files.map {|it| tag_for_file it }.join
  end

  def full_system_path(file)
    'public' + full_path(file)
  end
end