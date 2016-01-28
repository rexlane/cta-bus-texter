require 'spec_helper'

describe Parser do

  describe "permitted method checker" do
    it "returns the method name of a permitted method" do
      target = "map"
      expect(Parser.new.permitted_method("map")).to eq(target)
    end

    it "returns an error in response to a nonexistant method" do
      target = "no_matching_method"
      incoming_method_string = "do_bad_stuff"
      expect(Parser.new.permitted_method(incoming_method_string)).to eq(target)
    end
      
    it "returns both method and parameters from request string" do
      target = ["map", "chicago"]
      expect(Parser.new.parse_incoming_string("map chicago")).to eq(target)
    end

    it "returns method and nil if request has no parameters" do
      target = ["map", nil]
      expect(Parser.new.parse_incoming_string("map")).to eq(target)
    end

    it "calls an error if map has no parameters" do
      target = [HelpMessage.new.no_matching_method, nil]
      expect(Parser.new.map(nil)).to eq(target)
    end

  end

end