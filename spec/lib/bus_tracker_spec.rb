require 'spec_helper'

describe BusTracker do

  describe "split_into_loc_and_dir" do
    it "splits a string into location and direction" do
      string = "clark and lake west"
      expect(BusTracker.new.split_into_loc_and_dir(string)).to eq(["clark and lake","Westbound"]) 
    end
  end

  describe "find_closest_stop" do
    it "finds the nearest bus stop" do
      query = "clark and lawrence north"
      @bus_stop = BusTracker.new.find_closest_stop("clark and lawrence", "Northbound")
      expect(@bus_stop.stpid).to eq("17395")
    end
  end
end