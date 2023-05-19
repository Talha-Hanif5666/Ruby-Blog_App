class PostsController < ApplicationController
  # load_and_authorize_resource
  
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: params[:user_id])

    respond_to do |format|

      format.html 
      format.json {render :json => @posts}
    end
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @comments = @post.comments
    @like = Like.new

    respond_to do |format|
      format.html 
      format.json {render :json => @post}
    end
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(author_id: @user, title: params[:post][:title], text: params[:post][:text])
    @post.author_id = @user.id
    @post.save
    redirect_to user_posts_path(@user)
  end

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy
    redirect_to posts_path, notice: 'Post deleted successfully.'
  end
end
