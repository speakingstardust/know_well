require 'rails_helper'

RSpec.describe Manufacturer, type: :model do
  describe "attributes" do 
    let(:manufacturer) { Manufacturer.new }

    it "can have a name set" do 
      manufacturer.name = "Test Manufacturer Name" 

      manufacturer.save

      expect(manufacturer.name).to eq("Test Manufacturer Name")
    end
  end 
end
