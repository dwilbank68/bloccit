require 'rails_helper'
# per https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
include Warden::Test::Helpers
Warden.test_mode!

describe 'Visiting user profiles' do

  include TestFactories

  before do
    @user = authenticated_user
    @post = associated_post(user: @user)
    @comment = Comment.new(user: @user, body: 'A Comment')
    allow(@comment).to receive(:send_favorite_emails) # skipping an actual call to :send_favorite_emails?
    @comment.save
  end

  describe "not signed in" do
    it "shows profiles" do
      visit user_path(@user) # or just @user?
      expect(current_path).to eq(user_path(@user))

      expect( page ).to have_content(@user.name)
      expect( page ).to have_content(@post.title)
      expect( page ).to have_content(@comment.body)
    end
  end

  describe "signed in" do
    before do
      @user = authenticated_user
      @user.confirmed_at = Time.now
      @user.save
      login_as(@user, :scope => :user) # from Warden::Test::Helpers
      @post = associated_post(user: @user)

      @comment = Comment.new(user: @user, body: 'A Comment')
      allow(@comment).to receive(:send_favorite_emails) # skipping an actual call to :send_favorite_emails?
      @comment.save

      Warden.test_reset!
    end

    it "shows profiles" do
      visit user_path(@user) # or just @user?
      expect(current_path).to eq(user_path(@user))

      expect( page ).to have_content(@user.name)
      expect( page ).to have_content(@post.title)
      expect( page ).to have_content(@comment.body)
    end
  end

end