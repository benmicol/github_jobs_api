require './main.rb'

describe GitJobs do
    describe '#main' do
        it 'prints to console' do
            expect do
                GitJobs.new.main("Ruby","Durham")
            end.to output().to_stdout
        end
    end
end