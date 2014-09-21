require 'rails_helper'

describe Vote do

  describe "validations" do

    describe 'value validation' do
      it "only allows -1 or 1 as values" do

        vgood1 = Vote.create :value => 1
        vgood2 = Vote.create :value => -1
        vbad1 = Vote.create :value => 0
        vbad2 = Vote.create :value => 2
        vbad3 = Vote.create
        expect(vgood1.valid?).to eq(true)#eq(true)
        expect(vgood2.valid?).to eq(true)
        expect(vbad1.valid?).to eq(false)
        expect(vbad2.valid?).to eq(false)
        expect(vbad3.valid?).to eq(false)

      end
    end

  end

end