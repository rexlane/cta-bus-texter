require 'spec_helper'

describe Texter do
  describe "no_matching_method" do
    it "returns an error string" do
      expect(Texter.new.no_matching_method("string")).to eq("Sorry, I don't understand. For help, reply \"help\".")
    end
  end


  describe "get_location_coordinates" do
    it "returns array of latitude and longitude" do
      expect(Texter.new.get_location_coordinates("chicago")).to eq([41.878113,-87.629798])
    end
  end

  describe "get_formatted_address" do
    it "returns formatted address" do
      expect(Texter.new.get_formatted_address("chicago")).to eq("Chicago, IL, USA")
    end
  end

  describe "map method" do
    it "returns a static map url based on city name" do
      body = "chicago"
      expect(Texter.new.map(body)).to eq(["Chicago, IL, USA", "https://maps.googleapis.com/maps/api/staticmap?center=41.878113,-87.629798&zoom=16&size=400x400&key=#{ENV["GOOGLE_STATIC_MAPS_KEY"]}"])
    end

    it "returns a static map url based on intersection" do
      body = "western and milwaukee chicago"
      expect(Texter.new.map(body)).to eq(["N Milwaukee Ave & N Western Ave, Chicago, IL 60647, USA", "https://maps.googleapis.com/maps/api/staticmap?center=41.916779,-87.687322&zoom=16&size=400x400&key=#{ENV["GOOGLE_STATIC_MAPS_KEY"]}"])
    end
  end

  describe "define method" do
    it "returns a definition" do
      target = ":a thin round of unleavened cornmeal or wheat flour bread usually eaten hot with a topping or filling (as of ground meat or cheese)"
      expect(Texter.new.define("tortilla")).to eq(target)
    end
  end

end
