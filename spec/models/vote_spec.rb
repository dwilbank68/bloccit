require 'rails_helper'

describe Vote do

  describe "validations" do

    describe 'value validation' do
      it "only allows -1 or 1 as values" do

        vgood1 = Vote.new :value => 1
        vgood2 = Vote.new :value => -1
        vbad1 = Vote.new :value => 0
        vbad2 = Vote.new :value => 2
        vbad3 = Vote.new
        expect(vgood1.valid?).to eq(true)#eq(true)
        expect(vgood2.valid?).to eq(true)
        expect(vbad1.valid?).to eq(false)
        expect(vbad2.valid?).to eq(false)
        expect(vbad3.valid?).to eq(false)

      end
    end
  end

  describe 'after_save' do
    it "calls 'Post#update_rank' after save" do
      user = create(:user)
      post = create(:post, user:user)
      vote = Vote.new(value: 1, post: post)
      expect(post).to receive(:update_rank)
      vote.save
    end
  end


end
