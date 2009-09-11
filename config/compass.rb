Compass.configuration do |config|
  config.project_type    = :stand_alone
  config.http_path       = '/'
  config.css_dir         = 'public/stylesheets'
  config.sass_dir        = 'stylesheets'
  config.images_dir      = 'public'
  config.javascripts_dir = 'public/javascripts'
end

Compass.configuration.project_path = '.'
Sass::Plugin.options.merge! Compass.configuration.to_sass_engine_options
Sass::Plugin.options[:template_location] = Compass.configuration.sass_path