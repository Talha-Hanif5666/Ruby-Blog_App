class CommentsController < ApplicationController
  # load_and_authorize_resource
  protect_from_forgery except: %i[create update destroy]

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments

    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(author_id: @user.id, post: @post, text: params[:text])

    if @comment.save
      respond_to do |format|
        format.html { redirect_to user_post_path(@user, @post) }
        format.json { render json: @comment }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @comment.errors }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to post_path(@comment.post), notice: 'Comment deleted successfully.'
  end
end
