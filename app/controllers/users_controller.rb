class UsersController < ApplicationController
  def commenters
    @users = User.all
  end
end
