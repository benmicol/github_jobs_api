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
                languages = ["Ruby"] 
                response = gitjobs.api_request("Raleigh") 
                expect(response).to be_kind_of(Object)
            end
        end
    end
end