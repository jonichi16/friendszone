module PostsHelper
  def get_post_date(post)
    post.created_at.strftime("%B %d, %Y | %I:%M %P")
  end
end
