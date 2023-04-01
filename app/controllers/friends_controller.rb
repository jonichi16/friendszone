class FriendsController < ApplicationController
  def create
    @friend = current_user.friends.build(friend_params)

    if @friend.save
      redirect_to params[:target_url]
    else
      render params[:target_url], status: :unprocessable_entity
    end
  end

  private

  def friend_params
    params.require(:friend).permit(:friend_id)
  end
end
