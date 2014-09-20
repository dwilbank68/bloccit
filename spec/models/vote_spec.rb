require 'rails_helper'

describe Vote do

  describe "validations" do

    before do
      @post = Post.create(title: 'post title', body: 'post body')
    end

    describe 'value validation' do
      it "only allows -1 or 1 as values" do

        it "allows 1" do
          @post.votes.create(value: 1)
          expect (@post.votes).to eq(1)
        end

        it "allows -1" do
          @post.votes.create(value: -1)
          expect (@post.votes).to eq(-1)
        end

        it "disallows 2" do
          @post.votes.create(value: 2)
          expect (@post.votes).not_to eq(2)
        end

        it "disallows 0" do
          @post.votes.create(value: 0)
          expect (@post.votes).not_to eq(0)
        end

        # can't really write a test for nil until I see how model works and if it would crash the app
      end
    end

  end

end