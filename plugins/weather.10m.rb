#!/usr/bin/env rbenv-ruby

require 'dotenv'
require 'json'
require 'open-uri'

Dotenv.load(File.join __dir__, '../.env')

api_url = 'http://api.openweathermap.org/data/2.5/weather'
api_key = ENV['OPENWEATHERMAP_API_KEY']
city_id = ENV['OPENWEATHERMAP_CITY_ID']
url     = "#{api_url}?id=#{city_id}&appid=#{api_key}&units=metric"

json = JSON.parse(open(url).read)
temp = json['main']['temp'].round(1)

weather = case json['weather'][0]['main']
          when 'Clear'
            '☀️'
          when 'Clouds'
            '☁️'
          when 'Thunderstorm'
            '⛈'
          when 'Rain'
            '🌧'
          else
            json['weather'][0]['main']
          end

puts "#{weather} #{temp}°C"
