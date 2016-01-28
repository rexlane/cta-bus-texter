require 'spec_helper'

describe HelpMessage do

  describe "sorry" do
    it "says sorry" do
      expect(HelpMessage.new.all_help).to eq("Try one of these: BUS [location] [direction]; MAP [location]; DEFINE [word]")
    end
  end

  describe "no_matching_method" do
    it "responds to bad method" do
      expect(HelpMessage.new.no_matching_method).to eq("Sorry, I don't understand. Try one of these: BUS [location] [direction]; MAP [location]; DEFINE [word]")
    end
  end

end