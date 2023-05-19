class CommentsController < ApplicationController
  # load_and_authorize_resource
  protect_from_forgery :except => [:create, :update, :destroy]
  
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments

    respond_to do |format|
        
        format.html 
        format.json {render :json => @comments}
      end   

  end


  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

# Add here

# End here

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to post_path(@comment.post), notice: 'Comment deleted successfully.'
  end
end
