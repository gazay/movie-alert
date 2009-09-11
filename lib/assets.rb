require 'yaml'
require 'lib/assets/base'
require 'lib/assets/javascripts'
require 'lib/assets/stylesheets'

module Assets
  All = YAML.load_file 'config/assets.yml'

  def self.javascripts
    Javascripts
  end

  def self.stylesheets
    Stylesheets
  end
end