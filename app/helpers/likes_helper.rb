module LikesHelper
  def liked(user, post)
    post.likes.pluck(:user_id).include?(user.id)
  end

  def like_id(user, post)
    post.likes.where(user_id: user.id).first.id
  end
end
