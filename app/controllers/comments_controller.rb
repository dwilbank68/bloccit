class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @topic = @post.topic

    authorize @comment
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      redirect_to [@topic, @post]
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment successfully deleted."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Error deleting comment."
      redirect_to [@topic, @post]
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

end
