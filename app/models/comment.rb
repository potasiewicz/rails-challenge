class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :user_id, uniqueness: {scope: :movie, message: ' can add only one commnet to movie.'}
end
