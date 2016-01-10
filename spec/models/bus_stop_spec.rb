require 'spec_helper'

describe BusStop do
  # describe "get_cta_xpath_from(route,direction)" do
  # end

  # Ensure that app is successfully connecting to database
  describe "create_from_cta_api_xpath" do
    it "creates an object in the database" do
      expect{BusStop.create}.to change(BusStop, :count).by 1
      pp BusStop.last
    end
  end
end