module Javascripts
  extend Base
  
  def self.sources
    Assets::All['javascripts']
  end

  def self.tag(url)
    "<script src='#{url}' type='text/javascript'></script>"
  end

  def self.full_path(file)
    "/javascripts/#{file}.js"
  end
end