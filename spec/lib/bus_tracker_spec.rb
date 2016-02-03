require 'spec_helper'

describe BusTracker do
  # describe 'split_into_loc_and_dir' do
  #   it 'splits a string into location and direction' do
  #     string = 'clark and lake west'
  #     target = ['clark and lake chicago', 'Westbound']
  #     bus_tracker = BusTracker.new
  #     expect(bus_tracker.split_into_loc_and_dir(string)).to eq(target)
  #   end
  # end

  describe 'find_closest_stop' do
    it 'finds the nearest bus stop' do
      bus_tracker = BusTracker.new
      loc = 'clark and lawrence chicago'
      dir = 'Northbound'
      nearest_bus_stop = bus_tracker.find_closest_stop(loc, dir)
      expect(nearest_bus_stop[:stpid].to_s).to eq('17395')
    end
  end

  describe 'calculate_time_until_arrival' do
    it 'calculates times until arrival from predictions array' do
      current_time = '20160131 15:24:02'
      arrival_times = ['20160131 15:31', '20160131 15:48']
      target = [6, 23]
      tracker = BusTracker.new
      arrival_phrases = tracker.calculate_time_until_arrival(current_time, arrival_times)
      expect(arrival_phrases).to eq(target)
    end
  end

  describe 'humanize_minutes_to_arrival(minutes_array)' do
    it 'returns a human-readable string of arrival times' do
      minutes_array = [0, 1, 10]
      minutes_string = 'less than 1 minute, 1 minute, 10 minutes'
      expect(BusTracker.new.humanize_minutes_to_arrival(minutes_array)).to eq(minutes_string)
    end
  end
end
