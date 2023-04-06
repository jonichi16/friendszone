class CommentsController < ApplicationController
  before_action :set_comments

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new

    render partial: "comments/form", locals: { comment: @comment, post: @post }
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(user_id: current_user.id, content: comment_params[:content])

    respond_to do |format|
      if @comment.save
        format.turbo_stream
      end
      format.html { render partial: "comments/form", locals: { comment: @comment, post: @post } }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comments
    @post = Post.find(params[:post_id])
    @comments = @post.comments.includes(:user).reverse_order
  end
end
