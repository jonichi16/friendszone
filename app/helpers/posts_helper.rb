module PostsHelper
  def get_post_date(post)
    post.created_at.strftime("%B %d, %Y")
  end

  def get_post_time(post)
    post.created_at.strftime("%I:%M %P")
  end
end
