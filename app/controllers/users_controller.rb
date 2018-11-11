class UsersController < ApplicationController
  def commenters
    @users = User.includes(:comments)
  end
end
