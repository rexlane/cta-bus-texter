require 'spec_helper'

describe CtaApiIntegration do

  describe "cta_bus_routes" do
    it "gets route list from cta api" do
      expect(CtaApiIntegration.new.cta_bus_routes.count).to be > 100
      # expect(CtaApiIntegration.new.extract_all_bus_stops.count).to be > 100
    end
  end

  # describe "upcoming_arrivals" do
  #   it "gets upcoming arrivals" do 
  #     expect(CtaApiIntegration.new.upcoming_arrivals("22","17395")).to eq("")
  #   end
  # end


  describe "extract_all_bus_stops" do
    it "calls the right things" do
      integration = CtaApiIntegration.new
      expect(integration).to receive(:drop_all_stops_from_database) {}
      expect(integration).to receive(:cta_bus_routes) {["route"]}
      expect(BusStop).to receive(:get_cta_xpath_from).exactly(4).times 
      integration.extract_all_bus_stops
    end
  end

end