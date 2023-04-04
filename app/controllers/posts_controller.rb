class PostsController < ApplicationController
  def index
    # contains all posts
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.turbo_stream
        format.html { redirect_to root_path }
      else
        format.turbo_stream do
          render turbo_stream:
            turbo_stream.replace(
              "new_post",
              partial: "posts/form",
              locals: { post: @post }
            )
        end
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
