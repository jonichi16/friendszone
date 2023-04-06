module CommentsHelper
  def get_comment_date(comment)
    comment.created_at.strftime("%B %d, %Y | %I:%M %P")
  end
end
