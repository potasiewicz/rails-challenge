class MovieDetailsService
  def initialize(movies)
    @hydra = Typhoeus::Hydra.new
    @movies = movies
  end

  def load
    @movies.each do |movie|
      request = Typhoeus::Request.new("https://pairguru-api.herokuapp.com/api/v1/movies/#{URI.encode(movie.title)}", followlocation: true)
      request.on_complete do |response|
        movie.details = JSON.parse(response.body, object_class: OpenStruct)
      end
      @hydra.queue(request)
    end
    @hydra.run

    @movies
  end
end