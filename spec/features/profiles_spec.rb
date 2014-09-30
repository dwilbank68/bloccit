require 'rails_helper'
# per https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
include Warden::Test::Helpers
Warden.test_mode!

describe 'Visiting user profiles' do

  before do
    @user = create(:user)
    @post = create(:post, user:@user)

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
      @user = create(:user)
      @user.confirmed_at = Time.now
      @user.save
      login_as(@user, :scope => :user) # from Warden::Test::Helpers
      @post = create(:post, user:@user)

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