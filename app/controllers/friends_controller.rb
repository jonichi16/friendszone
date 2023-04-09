class FriendsController < ApplicationController
  before_action :set_friend, only: %i[destroy]

  def index
    @friends = Friend.includes(:friend).friends(params[:user_id])
  end

  def create
    @friend = current_user.friends.build(friend_params)

    respond_to do |format|
      if @friend.save
        format.turbo_stream
        format.html { redirect_to params[:target_url] }
      else
        render params[:target_url], status: :unprocessable_entity
      end
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
    delete_friend(current_user, @friend)
    delete_friend(@friend, current_user)

    redirect_to user_path(params[:id]), status: :see_other
  end

  private

  def friend_params
    params.require(:friend).permit(:friend_id)
  end

  def set_friend
    @friend = User.find(params[:id])
  end

  def delete_friend(user, friend)
    friendship = user.friends.find_by(friend_id: friend.id)
    user.friends.destroy(friendship) if friendship
  end
end
