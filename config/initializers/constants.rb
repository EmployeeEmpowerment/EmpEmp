# frozen_string_literal: true

GENDERS = YAML.safe_load(File.read(File.expand_path('config/initializers/genders.yml')))
RACES = YAML.safe_load(File.read(File.expand_path('config/initializers/races.yml')))
