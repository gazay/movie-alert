class Reloader
  def initialize(app)
    @app = app
    @last = last_mtime
  end

  def call(env)
    current = last_mtime
    if current > @last
      reload!
      @last = current
    end
    @app.call(env)
  end

  def reload!
    files.each {|file| $LOADED_FEATURES.delete file }
    Sinatra::Application.reset!
    require Sinatra::Application.app_file
  end

  def last_mtime
    files.map {|file| File.stat(file).mtime }.max
  end

  def files
    Dir['app/**/*.rb']
  end
end