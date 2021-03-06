class MovieDetailsService
  def initialize
    @api_base_url = 'https://pairguru-api.herokuapp.com/api/v1/movies/'
    @hydra = Typhoeus::Hydra.new
  end

  def load_collection(movies)
    movies.each do |movie|
      execute(movie)
    end
    @hydra.run
    movies
  end

  def load(movie)
    execute movie
    @hydra.run
    movie
  end

  def execute(movie)
    request = Typhoeus::Request.new("#{@api_base_url}#{URI.encode(movie.title)}")
    request.on_complete do |response|
      if response.success?
        movie.details = JSON.parse(response.body, object_class: OpenStruct).data.attributes
      else
        movie.details = OpenStruct.new({plot: 'n/a', rating: 'n/a'})
      end
    end
    @hydra.queue(request)
    movie
  end
end