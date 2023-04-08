module LikesHelper
  def liked(user, post)
    post.likes.pluck(:user_id).include?(user.id)
  end
end
