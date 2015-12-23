require 'spec_helper'

describe "texter_app" do
  
  # describe "base url" do 
  #   it "returns the thing you want" do
  #     get "/"
  #     pp last_response.body
  #   end
  # end

  describe "permitted method checker" do
    it "returns the method name of a permitted method" do
      target = "map"
      expect(Parser.new.permitted_method("map")).to eq(target)
    end

    it "returns an error in response to a nonexistant method" do
      target = "no_matching_method"
      incoming_method_string = "do_bad_stuff"
      expect(Parser.new.permitted_method(incoming_method_string)).to eq("no_matching_method")
    end
      
    it "returns both method and parameters from request string" do
      target = ["map", "chicago"]
      expect(Parser.new.parse_incoming_string("map chicago")).to eq(target)
    end
  end

  describe "coordinate getter" do
    it "returns array of latitude and longitude" do
      expect(Texter.new.get_location_coordinates("chicago")).to eq([41.878113,-87.629798])
    end
  end

  describe "address formatter" do
    it "returns formatted address" do
      expect(Texter.new.get_formatted_address("chicago")).to eq("Chicago, IL, USA")
    end
  end

  describe "static mapper" do
    it "returns a static map url based on city name" do
      body = "chicago"
      expect(Texter.new.map(body)).to eq([Texter.new.get_formatted_address(body), "https://maps.googleapis.com/maps/api/staticmap?center=41.878113,-87.629798&zoom=16&size=400x400&key=#{ENV["GOOGLE_STATIC_MAPS_KEY"]}"])
    end

    it "returns a static map url based on intersection" do
      body = "western and milwaukee chicago"
      expect(Texter.new.map(body)).to eq([Texter.new.get_formatted_address(body), "https://maps.googleapis.com/maps/api/staticmap?center=41.916779,-87.687322&zoom=16&size=400x400&key=#{ENV["GOOGLE_STATIC_MAPS_KEY"]}"])
    end
  end

  describe "define method" do
    it "correctly gets the definition of a word" do
      target = ":a thin round of unleavened cornmeal or wheat flour bread usually eaten hot with a topping or filling (as of ground meat or cheese)"
      expect(Texter.new.define("tortilla")).to eq(target)
    end
  end

end