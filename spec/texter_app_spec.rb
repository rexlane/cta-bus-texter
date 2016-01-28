require 'spec_helper'

describe "texter_app" do
  # it "calls the right things" do

  # end

  it "calls the right things" do
    expect(Parser.new.send("map", "western and milwaukee chicago")).to eq(["N Milwaukee Ave & N Western Ave, Chicago, IL 60647, USA", "https://maps.googleapis.com/maps/api/staticmap?center=41.916779,-87.68732290000001&zoom=16&size=400x400&key=#{ENV["GOOGLE_STATIC_MAPS_KEY"]}"])
  end

  describe "sorry" do
    it "says sorry" do
      expect(Parser.new.helpme).to eq(["Try one of these: BUS [location] [direction]; MAP [location]; DEFINE [word]", nil])
    end
  end

  describe "no_matching_method" do
    it "responds to bad method" do
      expect(Parser.new.no_matching_method).to eq(["Sorry, I don't understand. Try one of these: BUS [location] [direction]; MAP [location]; DEFINE [word]", nil])
    end
  end

end