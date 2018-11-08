require "rails_helper"

describe MovieDetailsService do
  before(:each) do
    @movie = (create :movie).decorate
    @api_request = stub_request(:get, "https://pairguru-api.herokuapp.com/api/v1/movies/#{@movie.title}")
  end

  describe "#load" do
    context 'api response status 200' do
      before(:each) {@api_request.to_return(body: '{"data":{"id":"6","type":"movie","attributes":{"title":"Godfather","plot":"coming soon","rating":9.2,"poster":"/godfather.jpg"}}}')}
      it 'should load rating and plot' do
        movie = MovieDetailsService.new.load(@movie)
        expect(movie.rating).to eq 9.2
        expect(movie.description).to eq 'coming soon'
      end
    end

    context 'api response status 500' do
      before(:each) {@api_request.to_return(status: [500, "Internal Server Error"])}
      it 'should set n/a for rating and plot' do
        movie = MovieDetailsService.new.load(@movie)
        expect(movie.rating).to eq 'n/a'
        expect(movie.description).to eq 'n/a'
      end
    end
    context 'api timeout' do
      before(:each) {@api_request.to_timeout}
      it 'should set n/a for rating and plot' do
        movie = MovieDetailsService.new.load(@movie)
        expect(movie.rating).to eq 'n/a'
        expect(movie.description).to eq 'n/a'
      end
    end

    context 'movie dont exist in api' do
      before(:each) {@api_request.to_return(body: '{"message":"Couldn\'t find Movie"}', status: 404)}

      it 'should set n/a for rating and plot' do
        movie = MovieDetailsService.new.load(@movie)
        expect(movie.rating).to eq 'n/a'
        expect(movie.description).to eq 'n/a'
      end
    end

  end
end




