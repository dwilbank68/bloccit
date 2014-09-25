class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    authorize favorite
    if favorite.save
      flash[:notice] = "Favorited"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Error in favoriting"
      redirect_to [@post.topic, @post]
    end

  end

  def destroy
    @post = Post.find(params[:post_id])
    this_fave = current_user.favorites.where(post_id:@post.id).last
    authorize this_fave
    if this_fave.destroy
      flash[:notice] = 'Unfavorited'
      redirect_to [@post.topic, @post]
    else
      flash[:notice] = 'Error in unfavoriting'
      redirect_to [@post.topic, @post]
    end
  end

end

