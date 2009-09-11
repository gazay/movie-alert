module Stylesheets
  extend Base
  
  def self.sources
    Assets::All['stylesheets']
  end

  def self.tag(url)
    "<link href='#{url}' rel='stylesheet' type='text/css' />"
  end

  def self.full_path(file)
    "/stylesheets/#{file}.css"
  end
end