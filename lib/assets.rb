require 'yaml'

module Assets
  extend self

  @assets = YAML.load_file 'config/assets.yml'

  def javascripts
    @assets['javascripts']
  end

  def stylesheets
    @assets['stylesheets']
  end

  def include_javascripts
    include_as :script_tag, javascripts
  end

  def include_stylesheets
    include_as :style_tag, stylesheets
  end

  private

  def include_as(tag, files)
    if Sinatra::Application.environment == :production
      return send tag, 'application_compressed'
    end

    files.inject '' do |html, file|
      html + send(tag, file)
    end
  end

  def script_tag(file)
    full_path = file[/^http/] ? file : "/javascripts/#{file}.js"
    "<script src='#{full_path}' type='text/javascript'></script>"
  end

  def style_tag(file)
    full_path = file[/^http/] ? file : "/stylesheets/#{file}.css"
    "<link href='#{full_path}' rel='stylesheet' type='text/css' />"
  end
end