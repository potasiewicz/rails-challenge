class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = Movie.find(params[:movie_id])
    @comment = Comment.new comment_params
    @comment.movie = @movie
    @comment.user = current_user
    @comment.save
    if @comment.errors.size > 0
      redirect_to @movie, alert: @comment.errors.full_messages.join(", ")
    else
      redirect_to @movie, notice: I18n.t('comment.created')
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @comment = Comment.find(params[:id])
    unless current_user == @comment.user
      redirect_to @movie, alert: I18n.t('comment.permission_deny')
      return
    end

    @comment.destroy
    redirect_to @movie, notice: I18n.t('comment.destroy')
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
