require 'rails_helper'

describe FavoritesController do

  include Devise::TestHelpers

  before do
    @user = create(:user)
    @post = create(:post, user:@user)
    topic = Topic.create
    sign_in @user
  end

  describe '#create' do
    it "creates fave for current user and specified post" do
      expect(@user.favorites.find_by_post_id(@post.id)).to eq(nil)

      post :create, {topic_id: Topic.create.id, post_id: @post.id}

      expect(@user.favorites.find_by_post_id(@post.id).class).to eq(Favorite)
    end
  end

  describe '#destroy' do
    it "destroys fave for current user and post" do
      favorite = @user.favorites.where(post: @post).create
      expect(@user.favorites.find_by_post_id(@post.id).class).to eq(Favorite)

      delete :destroy, { topic_id: Topic.create.id, post_id: @post.id, id: favorite.id }

      # expect(@user.favorites.find_by_post_id(@post.id).class).to eq(nil)
      expect(@user.favorites.find_by_post_id(@post.id).class).to eq(NilClass)
    end
  end

end