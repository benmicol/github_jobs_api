#Require the following to make HTTP requests and parse JSON
require 'uri'
require 'net/http'
require 'json'

#Define an array of cities.
cities = ["Boston", "San Francisco", "Los Angeles","Denver","Boulder","Chicago","New York", "Raleigh"]
#Define an array of languages. The first element is the language name and the second element is the name formatted for the search query.
languages = [["Java","java"],["C#","C%23"],["Python","Python"],["Swift","Swift"],["Objective-C","Objective-C"],["Ruby","Ruby"],["Kotlin","Kotlin"],["Go","%22 Go %22 OR Golang"],["C++","C%2B$2B"],["Scala","%22scala %22 OR scala -scalab"]]

#GitJobs main function is to produce a list of Cities and the trending programming languages taken from GitHub Jobs API.
class GitJobs
    #main method takes the arrays of cities and languages as arguments and loops through each making requests and formatting the results.
    def main(cities,languages)
        #Loop through each city in the array
    cities.each do |city| 
        #Initialize count for total number of listings across all languages in the respective city
        count = 0
        #Initialize array that the results will be pushed to.
        results = []
        #Output the header for the city
        puts city + ":"
        #Loop through each language in the array for the current city
        languages.each do |lang| 
          #Add the listing count for the current language to the total
          count = count + jobs_api(city,lang[1])
          #Push the language name and the number of results to the results array.
          results.push([lang[0],jobs_api(city,lang[1])])
        end
        #If the number of results is greater than zero loop through each result in the array to sort and format them to be output.
        if count>0
          #Loop through each result
          results.each do |item|
            #Convert the number of listings for each language into a percentage.
            item[1] = (((item[1].to_f / count.to_f) *100).round())
          end
          #Sort descending by percentage
          sorted = results.sort_by{|x,y|y}.reverse
          #Loop through sorted results filtering out results with zero listings and formatting for output
          sorted.each do |item|
            #If the given language has more than zero results
            if item[1] >0
              #Output "- Langauge: 50%"
              puts "- "+item[0]+": "+item[1].to_s + " %"
            end
          end
        #Otherwise, if the current city has no listings for any of the languages, output "No Results".
        else
          puts "- No Results"
        end
      end
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
