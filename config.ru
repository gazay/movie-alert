require 'config/dependencies'
require 'config/compass'
require 'config/database'
require 'lib/subscription'
require 'lib/assets'
require 'lib/reloader'
require 'app/helpers'
require 'app/application'

configure :development do
  use Reloader
  before do
    Sass::Plugin.update_stylesheets if request.path_info == '/'
  end
end

set :app_file,  'app/application.rb'
set :views,     'app/views'
set :public,    'public'

run Sinatra::Application