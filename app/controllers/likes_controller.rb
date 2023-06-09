class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    respond_to do |format|
      if @like.save
        format.turbo_stream
        format.html { redirect_to root_path }
      end
    end
  end

  def dislike
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user_id: current_user.id)
    @like.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end
end
