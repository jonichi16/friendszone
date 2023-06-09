class UsersController < ApplicationController
  def index
    @users = User.people(current_user)
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.includes(:likes).reverse_order
  end
end
