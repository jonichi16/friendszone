module FriendsHelper
  def sender(user, friend)
    u_friend = user.friends.find_by(friend_id: friend.id)

    u_friend&.accepted?
  end
end
