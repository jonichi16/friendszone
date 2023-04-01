module FriendsHelper
  def friends(user, friend)
    u_friend = user.friends.find_by(friend_id: friend.id)
    f_friend = friend.friends.find_by(friend_id: user.id)

    u_friend&.accepted? && f_friend&.accepted?
  end

  def sender(user, friend)
    u_friend = user.friends.find_by(friend_id: friend.id)

    u_friend&.accepted?
  end

  def receiver(user, friend)
    f_friend = friend.friends.find_by(friend_id: user.id)

    f_friend&.accepted?
  end
end
