class FriendsController < ApplicationController
  def index
    @friends = Friend.includes(:friend).friends(params[:user_id])
  end

  def create
    @friend = current_user.friends.build(friend_params)

    if @friend.save
      redirect_to params[:target_url]
    else
      render params[:target_url], status: :unprocessable_entity
    end
  end

  def update
    @friend = current_user.friends.find_by(friend_params)

    if @friend.update(status: 1)
      redirect_to user_path(params[:id])
    else
      render user_path(params[:id]), status: :unprocessable_entity
    end
  end

  def destroy
    @friend = Friend.find_by(friend_id: params[:id])
    current_user.friends.destroy(@friend)

    redirect_to user_path(params[:id]), status: :see_other
  end

  private

  def friend_params
    params.require(:friend).permit(:friend_id)
  end
end
