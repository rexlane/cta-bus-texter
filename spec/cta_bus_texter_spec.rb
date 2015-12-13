require 'spec_helper'

describe "cta_bus_texter" do
  
  # describe "base url" do 
  #   it "returns the thing you want" do
  #     get "/"
  #     pp last_response.body
  #   end
  # end

  describe "permitted method checker" do
    it "returns the method name of a permitted method" do
      incoming_method_string = "map"
      expect(permitted_method(incoming_method_string)).to eq("map")
    end

    it "returns an error in response to a nonexistant method" do
      incoming_method_string = "do_bad_stuff"
      expect(permitted_method(incoming_method_string)).to eq("no_matching_method")
    end
      
  end

  describe "coordinate getter" do
    it "returns array of latitude and longitude in response to a location query" do
      location_query = "chicago"
      expect(get_location_coordinates(location_query)).to eq([41.878113,-87.629798])
    end
  end

  describe "address formatted" do
    it "returns formatted address in response to a location query" do
      location_query = "chicago"
      expect(get_formatted_address(location_query)).to eq("Chicago, IL, USA")
    end
  end

  describe "static map" do
    it "returns a static map url based on city name" do
      body = "chicago"
      expect(map(body)).to eq("https://maps.googleapis.com/maps/api/staticmap?center=41.878113,-87.629798&zoom=16&size=400x400&key=#{ENV["GOOGLE_STATIC_MAPS_KEY"]}")
    end

    it "returns a static map url based on intersection" do
      body = "western and milwaukee chicago"
      expect(map(body)).to eq("https://maps.googleapis.com/maps/api/staticmap?center=41.916779,-87.687322&zoom=16&size=400x400&key=#{ENV["GOOGLE_STATIC_MAPS_KEY"]}")
    end

  end

end