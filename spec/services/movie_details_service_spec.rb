require "rails_helper"

describe MovieDetailsService do
  subject {MovieDetailsService.new.load(movie)}

  shared_examples 'invalid api response' do
     it "should set rating and plot as n/a" do
       expect(subject.rating).to eq 'n/a'
       expect(subject.description).to eq 'n/a'
     end
   end

  before(:each) do
    @api_request = stub_request(:get, "https://pairguru-api.herokuapp.com/api/v1/movies/#{movie.title}")
  end

  describe "#load" do
    let(:movie) {(create :movie).decorate}
    context 'api response status 200' do
      before(:each) {@api_request.to_return(body: '{"data":{"id":"6","type":"movie","attributes":{"title":"Godfather","plot":"coming soon","rating":9.2,"poster":"/godfather.jpg"}}}')}

      it 'should load rating and plot' do
        expect(subject.rating).to eq 9.2
        expect(subject.description).to eq 'coming soon'
      end
    end

    context 'api response status 500' do
      before(:each) {@api_request.to_return(status: [500, "Internal Server Error"])}
      it_behaves_like "invalid api response"
    end
    context 'api timeout' do
      before(:each) {@api_request.to_timeout}
      it_behaves_like "invalid api response"
    end

    context 'movie dont exist in api' do
      before(:each) {@api_request.to_return(body: '{"message":"Couldn\'t find Movie"}', status: 404)}
      it_behaves_like "invalid api response"
    end
  end
end




