class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new(author_id: @user.id, post: @post, text: params[:comment][:text])
    @comment.save

    redirect_to user_posts_path(@user, @post)
  end
  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to post_path(@comment.post), notice: "Comment deleted successfully."
  end
  
end
