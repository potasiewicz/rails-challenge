class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def new
    @movie = Movie.find(params[:movie_id])
    @comment = Comment.new comment_params
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @comment = Comment.new comment_params
    @comment.movie = @movie
    @comment.user = current_user
    @comment.save
    redirect_to @movie, :flash => { :error => @comment.errors.full_messages }
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
