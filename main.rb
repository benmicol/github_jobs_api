#Require the following to make HTTP requests and parse JSON
require 'uri'
require 'net/http'
require 'json'

#Define an array of cities and an array of programming languages that will be passed.
cities = ["Boston", "San Francisco", "Los Angeles","Denver","Boulder","Chicago","New York", "Raleigh"]

languages = ["Java","C#","Python","Swift","Objective-C","Ruby","Kotlin","Golang","C++","Scala"]

#GitJobs main function is to produce a list of Cities and the trending programming languages taken from GitHub Jobs API.
class GitJobs
    def main(cities,languages)
        puts jobs_api(cities[0],languages[0])
    end
    #jobs_api method takes a programming language and location as arguments and returns the number of positions asking for that language.
    def jobs_api(location, language)
        #GitHub Jobs url
        url = "https://jobs.github.com/positions.json?location="+location+"&description="
        #Escape and parse URL for proper formatting
        escaped_url = URI.escape(url)
        parsed_url = URI.parse(escaped_url+language)
        #Make the HTTP request
        request = Net::HTTP.get(parsed_url)
        #Parse the JSON response
        response = JSON.parse(request)
        #Return the number of listings
        response.length
      end
end

request = GitJobs.new
request.main(cities,languages)
