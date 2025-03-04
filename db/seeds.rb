# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
require_relative 'seeds/theater.rb'
require_relative 'seeds/screens'
# require_relative 'seeds/theaters_and_screens'
require_relative 'seeds/movies'
require_relative 'seeds/sheets'
# require_relative 'seeds/schedules.rb'
