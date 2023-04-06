class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new

    render partial: "comments/form", locals: { comment: @comment, post: @post }
  end

  private

  def comment_params
    params.permit(:post_id)
  end
end
