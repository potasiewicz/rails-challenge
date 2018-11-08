require "rails_helper"

describe MovieDetailsService do
  describe "#load" do
    it 'should load rating and plot' do

      movie = (create :movie).decorate
      stub_request(:get, "https://pairguru-api.herokuapp.com/api/v1/movies/#{movie.title}")
      .to_return(body: '{"data":{"id":"6","type":"movie","attributes":{"title":"Godfather","plot":"coming soon","rating":9.2,"poster":"/godfather.jpg"}}}')

      movie = MovieDetailsService.new.load(movie)
      expect(movie.rating).to eq 9.2
      expect(movie.description).to eq 'coming soon'
    end
  end
end




