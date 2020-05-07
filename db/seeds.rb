# User.create(:name =>'Lauren')
# User.create(:name =>'Phyllis')
# User.create(:name =>'Phyllis')
require 'pry'
require 'net/http'
require 'open-uri'
require 'json'
require 'httparty'

url = "https://lingua-robot.p.rapidapi.com/language/v1/entries/en/"

uri = URI.parse(url)

response = Net::HTTP.get_response(uri)
binding.pry

data = JSON.parse(response.body)
response = HTTParty.get(url)

# response[" "].each do |c| 
# #     {
# #   "entries": [
# #     {
# #       "entry": "example",
   
# end

