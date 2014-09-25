require 'rails_helper'

describe User do

  include TestFactories

  describe '#favorited(post)' do

    before do
      @post = associated_post
      @user = authenticated_user
    end

    it "returns 'nil' if user has not favorited the post" do
      @user.favorited(@post)
    end

    it "returns appropriate favorite if it exists" do
      @user.favorites.where(post: @post).create
      @user.favorited(@post)
    end

  end

end