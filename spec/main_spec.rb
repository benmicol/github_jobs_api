require './main.rb'


describe GitJobs do
    subject(:gitjobs) { GitJobs.new }
    describe '#get_trends' do
        context 'when #main is given an array of cities and languages' do
            it 'prints to console' do
                expect do
                    cities = ["Raliegh"]
                    languages = ["Ruby"]
                    gitjobs.get_trends(cities,languages)
                end.to output().to_stdout
            end
        end
    end
    describe '#api_request' do
        context 'when #api_request is given a city' do
            it 'returns a JSON formatted response' do
                cities = ["Raliegh"]
                response = gitjobs.api_request("Raleigh") 
                expect(response).to be_kind_of(Object)
            end
        end
    end
    describe '#match_listings' do
        context 'when #match_listings is passed a city, jobs array and languages array' do
            it 'returns an array of results' do
                response = gitjobs.match_listings("Raleigh",[["Raleigh","Python"]],[["Python",/Python|python/],["Swift",/Swift|swift/]])
                expect(response).to be_kind_of(Array)
                expect(response.length).to eq(2)
                expect(response[0]).to eq(["Python", 1])
            end
        end
    end
    describe '#results_output' do
        context 'when #output is passed a city, results array and count' do
            it 'prints a formatted result if their are results' do
                expect do
                    gitjobs.results_output("Raleigh",[["Python",2],["Ruby",4]],6)
                end.to output("Raleigh:\n- Ruby: 67 %\n- Python: 33 %\n").to_stdout
            end
            it 'prints "no results" if their are 0 results' do
                expect do
                    gitjobs.results_output("Raleigh",[["Python",0],["Ruby",0]],0)
                end.to output("Raleigh:\n- No Results\n").to_stdout
            end
        end
    end
end