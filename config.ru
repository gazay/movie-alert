require 'config/dependencies'
require 'config/compass'
require 'config/database'
require 'lib/subscription'
require 'app/helpers'
require 'app/application'

configure :development do  
  before do    
    Sass::Plugin.update_stylesheets if request.path_info == '/'
  end
end

configure :production do
  Sass::Plugin.options[:style] = :compressed
  Sass::Plugin.update_stylesheets
end

set :views,   'app/views'
set :public,  'public'

run Sinatra::Application