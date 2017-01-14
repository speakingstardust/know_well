require 'rails_helper'

RSpec.describe Jig, type: :model do
  describe "validations" do
    let(:jig) { Jig.new }

    it "requires a name" do
      jig.cleaning_charge = 6.50
      jig.save
      expect(Jig.all.count).to eq(0)
    end
  end
end
