# Github Jobs API Coding Test
A Ruby-based app that uses the [Github Jobs API](https://jobs.github.com/api) to help show programming language trends across the following cities:
|Cities|Languages|
|---|---|
|Boston|Java|
|San Francisco|C#|
|Los Angeles|Python|
|Denver|Swift|
|Boulder|Objective-C|
|Chicago|Ruby|
|New York|Kotlin|
|Raleigh|Go|
| |C++|
| |Scala|
## Getting set up
* Main app file is main.rb and is set up to run and display results.
* Unit tests are located in the "main_spec.rb" file in the "spec" folder.
## Challenges I ran into
* Getting accurate search results from GitHub Jobs
    * Since the names of certain programming languages are more generic than others (looking at you "Go"), you have to account for false positive results.
    * For example, searching for "Scala" will return listings that contain the words "scalable", "scalability", etc.
    * I spent a lot of time experimenting with different search operators to improve results, but could never find a good a way to get the desired results.
    * Since I could not figure out a way to get exact matches from GitHub's search it was impossible for me to seperate "Java" lisitings from "Javascript" in all cases.
    * The solution I ended up with was to simply pull all the listings and filter them using RegEx in Ruby which wound up being a much simpler solution.
* Long runtime
    * My first version of this app took almost 15 seconds to run. I was making an API request for each search query which meant a total of 80 requests were made.
    * My solution was to rewrite my API method to make the minimum number of requests to get all the listings I needed and then process them in Ruby.
    * The result was a reduction in run time from 14.784 seconds down to 1.317 seconds, a drastic improvement!
## Areas of the code I'm most proud of
* Speed
    * As I mentioned above I was able to drastically improve the speed at which this app runs by minimizing the number of API requests it makes.
* RegEx Matchers
    * Instead of coming up with URL queries to get the correct listings I was able to filter the results using Regeular Expression matching.
    * For example, to get accurate results for "Go" I have a regex that matches "/\bGo\b|GoLang|golang|Golang/]" which minimizes the number of false positive results.
* Readability
    * I did my best to keep the code organized and readable with detailed comments
## Areas of the code I'm least proud of
* Refactoring
    * While I am proud of the readability of my code I am confident that given more time I could refactor and reduce the total lines of code needed significantly.
* Unit Testing
    * My unit tests account for the basic functionality of the app and its methods by I would like to flesh them out further to account for errors and other edge cases.
## Tradeoffs I made
* Static Inputs
    * The inputs (list of cities & list of languages) are predefined for this app so I assigned them to static variables for this test. Ideally you would be able to run this program given any number of cities/languages.
* Conciseness
    * Much of the logic in the app is more verbose than I would normally have in a finished/optimized application. This is a tradeoff of time.
* API Requests
    * I could have requested all the listings on GitHub jobs since there are less than 200 total, but to keep it simple I made one request per city.
## Next areas of focus moving towards production
* Unit tests
    * Add more unit tests to fully cover all intended and unintended behavior plus edge cases.
* Refactor
    * Refactor code and review to ensure best practices/naming conventions are followed.
* Refine Results
    * Further refine search results to make sure that the data is accurate.
* Dynamic Input
    * Add flexible input to the app so that it can be used with different cities/languages.
* UI/UX
    * Depending on the use case for this app it may be appropriate to add a user interface.
* Pagination
    * It was not an issue in my case but if GitHub Jobs becomes more popular it will be crucial to implement a way to account for pagination in API requests if the number of results is greater than 50.