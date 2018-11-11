class UsersController < ApplicationController
  def commenters
    @commenters = Comment.includes(:user)
                      .joins(:user)
                      .where({created_at: (DateTime.now - 7.days)..DateTime.now})
                      .group('users.name')
                      .limit(10)
                      .count
                      .sort_by {|name, comments| comments}
                      .reverse
  end
end
