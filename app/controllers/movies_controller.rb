class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = MovieDetailsService.new.load_collection Movie.all.decorate
  end

  def show
    movie = MovieDecorator.find(params[:id])
    @movie = MovieDetailsService.new.load movie
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_later
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    ExportMoviesJob.perform_later(current_user)
    redirect_to root_path, notice: "Movies exported"
  end
end
