class UsersController < ApplicationController
  def commenters
    @commenters = UserService.new.top_commenters
  end
end
