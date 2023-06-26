require 'geocoder'
require 'date'
require 'json'
require 'open-uri'
require 'dotenv/load'
require 'pry-byebug'


def fetch_weather(message)
  # Accepted message:
  # ~~~~~ weather in XXXXX
  #  ^anything          ^will become the location
  location = message.match(/.*eather in (\w+).*/)[1]

  # Coordinates from keyword
  # coord = Geocoder.search(location).first.coordinates
  api_key = ENV["WEATHER_API"]
  url = "https://api.openweathermap.org/data/2.5/forecast?q=#{location}&appid=#{api_key}"

  begin
    data_serialized = URI.open(url).read
  rescue OpenURI::HTTPError => e
    return { mostly: '', temps: '', report: 'No weather forecast for this city...' }
  end
  data = JSON.parse(data_serialized) #['daily'][0..3]

  # Retrieve the current weather information
  current_weather = data['list'][0]

  temperature = (current_weather['main']['temp']/10).round(2)
  feels_like = (current_weather['main']['feels_like']/10).round(2)
  weather_description = current_weather['weather'][0]['description']
  humidity = current_weather['main']['humidity']

  report = ""
  report += "Temperature: #{temperature}°C \n"
  report += "Feels like: #{feels_like}°C \n"
  report += "Weather description: #{weather_description} \n"
  report += "Humidity: #{humidity} \n"
  return report

end
