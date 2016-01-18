require 'spec_helper'

describe HelpMessage do
  describe "sorry" do
    it "says sorry" do
      expect(HelpMessage.new.all_help).to eq("Try texting:<br/>bus [location] [direction]<br/>map [location]<br/>define [word]<br/>")
    end
  end

  describe "no_matching_method" do
    it "responds to bad method" do
      expect(HelpMessage.new.no_matching_method).to eq("Sorry, I don't understand. Try texting:<br/>bus [location] [direction]<br/>map [location]<br/>define [word]<br/>")
    end
  end

end