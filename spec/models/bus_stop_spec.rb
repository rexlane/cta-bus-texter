require 'spec_helper'

describe BusStop do
  describe "get_cta_xpath_from(route,direction)" do
    it "creates a new object based on a stop" do
      expect(BusStop.get_cta_xpath_from("route", "direction")).to receive(:create_from_cta_api_xpath)
    end
  end

  # Ensure that app is successfully connecting to database
  describe "create_from_cta_api_xpath" do
    it "creates an object in the database" do
      expect{BusStop.create}.to change(BusStop, :count).by 1
      pp BusStop.last
    end
  end
end