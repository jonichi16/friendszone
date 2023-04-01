class UsersController < ApplicationController
  def index
    @users = User.people(current_user)
  end
end
