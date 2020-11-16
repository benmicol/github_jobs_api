require './main.rb'

describe GitJobs do
    describe '#main' do
        it 'prints to console' do
            expect do
                GitJobs.new.main("Ruby","Durham")
            end.to output().to_stdout
        end
    end
    describe '#jobs_api' do
        it 'returns an integer >= 0' do
            gj = GitJobs.new 
            listings = gj.jobs_api("Ruby","Durham") 
            expect(listings).to be_kind_of(Integer)
            expect(listings).to be >= 0
        end
    end
end