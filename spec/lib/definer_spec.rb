require 'spec_helper'

describe Definer do
  describe "define method" do
    it "returns a definition" do
      target = "tortilla: :a thin round of unleavened cornmeal or wheat flour bread usually eaten hot with a topping or filling (as of ground meat or cheese)"
      expect(Definer.new.define("tortilla")).to eq(target)
    end
  end
  
end