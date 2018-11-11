require 'rails_helper'

describe CommentsController do
  describe 'POST #create' do
    before(:each) {@params = {comment: {content: 'my first go'}, movie_id: create(:movie).id}}
    it 'sign in user can create comment' do
      sign_in create(:user)

      expect{ post(:create, params: @params) }.to change{ Comment.count }.by(1)
    end
    it 'unsign user cannot create comment' do
      expect{ post(:create, params: @params) }.not_to change{ Comment.count }
    end
  end
  describe 'DELETE #destroy' do
    it 'user can remove own comment' do
      user = create(:user)
      sign_in user
      comment = create(:comment, user: user)

      expect{ delete(:destroy, params: {movie_id: comment.movie.id, id: comment.id}) }.to change{ Comment.count }.by(-1)
    end

    it 'user cannot remove other users comments' do
      user = create(:user)
      sign_in user
      comment = create(:comment)

      expect{ delete(:destroy, params: {movie_id: comment.movie.id, id: comment.id}) }.not_to change{ Comment.count }
    end
  end
end