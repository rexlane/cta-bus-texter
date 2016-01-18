require 'spec_helper'

describe BusTracker do

  describe "split_into_loc_and_dir" do
    it "splits a string into location and direction" do
      string = "clark and lake west"
      expect(BusTracker.new.split_into_loc_and_dir(string)).to eq(["clark and lake chicago","Westbound"]) 
    end
  end

  describe "find_closest_stop" do
    it "finds the nearest bus stop" do
      location = "clark and lawrence chicago"
      direction = "Northbound"

      nearest_bus_stop = BusTracker.new.find_closest_stop("clark and lawrence chicago", "Northbound")
      expect(nearest_bus_stop[:stpid].to_s).to eq("17395")
    end
  end

  describe "bus method" do
    it "returns the nearest bus stop as a pretty string" do
      request_string = "clark and lawrence north"
      expect(BusTracker.new.bus(request_string)).to eq("22 Northbound from Clark & Lawrence")
    end
  end

end