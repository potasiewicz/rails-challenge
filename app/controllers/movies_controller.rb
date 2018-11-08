class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate

    hydra = Typhoeus::Hydra.new
    @movies.each do |movie|
      request = Typhoeus::Request.new("https://pairguru-api.herokuapp.com/api/v1/movies/#{URI.encode(movie.title)}", followlocation: true)
      request.on_complete do |response|
        movie.details = JSON.parse(response.body, object_class: OpenStruct)
      end
      hydra.queue(request)
    end
    hydra.run
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end
end
