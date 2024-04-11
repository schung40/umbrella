#start off with "gem install bundler"

pirate_key = ENV.fetch("PIRATE_WEATHER_KEY")
gmap_key = ENV.fetch("GMAPS_KEY")

require "http"
require "json"

puts "Where are you?"

user_location = gets.chomp

puts "Checking the weather at #{user_location}...."

gmap_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=" + gmap_key

raw_gmap_response = HTTP.get(gmap_url)

parsed_response = JSON.parse(raw_gmap_response)
results_array = parsed_response.fetch("results")

first_result_hash = results_array.at(0) #idk what this is....

geometry_array = first_result_hash.fetch("geometry")
location_array = geometry_array.fetch("location")

latitude = location_array.fetch("lat")
longitude = location_array.fetch("lng")

puts "Your coordinates are lat: #{latitude}, #{longitude} ."

pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_key + "/#{latitude},#{longitude}"

raw_pirate_response = HTTP.get(pirate_weather_url)

parsed_pirate_response = JSON.parse(raw_pirate_response)

currently_hash = parsed_pirate_response.fetch("currently")
current_temp = currently_hash.fetch("temperature")

puts "It is currently #{current_temp}°F."
