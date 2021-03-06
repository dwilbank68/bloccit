class Topics::PostsController < ApplicationController

  def show
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
    authorize @topic
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post # comes from 'include pundit' in ApplicationController
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.new(params.require(:post).permit(:title, :body))
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    authorize @post

    if @post.save_with_initial_vote
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    title = @post.title
    authorize @post

    if @post.destroy
      flash[:notice] = "#{title} successfully deleted."
      redirect_to @topic
    else
      flash[:error] = "Error deleting post."
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  # def save_with_initial_vote(the_post)
  #   ActiveRecord::Base.transaction do
  #     the_post.save
  #     the_post.create_vote
  #   end
  # end

end
