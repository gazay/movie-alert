require "yaml"

Actors = YAML.load_file('cache/actors.yml').join("\n")
Directors = YAML.load_file('cache/directors.yml').join("\n")
Genres = YAML.load_file('cache/genres.yml').join("\n")

