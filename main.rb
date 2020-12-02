#Require the following to make HTTP requests and parse JSON
require 'uri'
require 'net/http'
require 'json'

#Define an array of cities that will be passed.
cities = ["Boston", "San Francisco", "Los Angeles","Denver","Boulder","Chicago","New York", "Raleigh"]

#Define an array of programming languages. The first element is the name of the language and the second element is a Regular Expression that will be passed when filtering for matching listings.
languages = [["Java",/\bJava\b|\bjava\b/],["C#",/C\#/],["Python",/Python|python/],["Swift",/Swift|swift/],["Objective-C",/Objective-C/],["Ruby",/Ruby|ruby/],["Kotlin",/Kotlin|kotlin/],["Go",/\bGo\b|GoLang|golang|Golang/],["C++",/C\+\+|c\+\+/],["Scala",/\bScala\b|\bscala\b/]]

#GitJobs main function is to produce a list of Cities and the trending programming languages taken from GitHub Jobs API.
class GitJobs 
  #get_trends initializes instance variables, taking in cities and languages as arguments and outputs language trends in given cities.
  def get_trends(cities,languages)
    #Initialize instance variables
    @cities = cities
    @languages = languages
    @jobs_array = []
    #Loop through each city making an API request for all jobs.
    @cities.each do |city|
      job_list = api_request(city)
      #Loop through each listing and add the city name and desciption to an array.
      job_list.each do |listing|
        @jobs_array.push([city,listing['description']])
      end
      #Call the match_listings method, passing in the given city, jobs array and languages array.
      results = match_listings(city,@jobs_array,@languages)
      #Sum the total number of listings for the given city.
      count = results.map{|e| e[1]}.reduce(:+)
      #Call the output method, passing in the city, results array, and count.
      results_output(city,results,count)
    end
  end
  #API method takes a city as an argument and returns all listings for that city.
  def api_request(city)
    url = "https://jobs.github.com/positions.json?utf8=%E2%9C%93&description=&location="+city
    #Escape and parse URL for proper formatting.
    escaped_url = URI.escape(url)
    parsed_url = URI.parse(escaped_url)
    #Make the HTTP request.
    request = Net::HTTP.get(parsed_url)
    #Parse the JSON response.
    response = JSON.parse(request)
    #Returns all listings for the given city.
    return response
  end
  #This method takes a city, jobs array and languages array as an argument and filters through the listings that match each language before adding them to an array.
  def match_listings(city,jobs_array,languages)
    #Initialize the array our results will be added to.
    results = []
    #Filter for only the job listings in the current city.
    city_jobs = jobs_array.select { |n,m| n == city }
    #Loop through each language and record the number of matching listings.
    languages.each do |lang|
      #Filter for only job listings where the programming language matches our RegEx from the languages array.
      lang_results = city_jobs.select { |n,m| m.match? lang[1]}
      #Add the language name and number of matching listings to the results array.
      results.push([lang[0],lang_results.length])
    end
    #Return the results arary
    return results
  end
  #This method sorts and formats the data for output.
  def results_output(city,results,count)
    #Output the name of the current city.
    puts "#{city}:"
    #If there are a positive number of listings format the results.
    if count>0
      #Loop through each result.
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
          puts "- #{item[0]}: #{item[1].to_s} %"
        end
      end
    #Otherwise, if the current city has no listings for any of the languages, output "No Results".
    else
      puts "- No Results"
    end
  end
end
#Create an instance of GitJobs
GitJobs.new.get_trends(cities,languages)
