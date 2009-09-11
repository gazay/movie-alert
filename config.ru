require 'dependencies'
require 'config/compass'
require 'database'
require 'scripts/subscription'
require 'helpers'
require 'application'

configure :development do  
  before do    
    Sass::Plugin.update_stylesheets if request.path_info == '/'
  end
end

configure :production do
  Sass::Plugin.options[:style] = :compressed
  Sass::Plugin.update_stylesheets
end

run Sinatra::Application