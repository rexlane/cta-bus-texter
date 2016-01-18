require 'active_support/core_ext/time/calculations.rb'

class BusTracker

  def direction_pairs
    { "n" => "Northbound", "s" => "Southbound", "w" => "Westbound", "e" => "Eastbound" }
  end

  def split_into_loc_and_dir(args)
    location = "#{args.rpartition(' ').first} chicago"
    direction = args.rpartition(' ').last.downcase
    if direction_pairs.has_key?(direction[0])
      direction = direction_pairs[direction[0]]
    else
      # what happens if no direction?
      direction = nil
    end
    return location, direction
  end

  def find_closest_stop(loc, dir)
    nearest_bus_stops = BusStop.near(loc).where(dir: dir)

    # can allow for multiple routes at a single stop?
    nearest_bus_stops.first
  end

  def time_until_arrival(route, stop_id)
    current_time = CtaApiIntegration.new.current_time
    arrival_times = CtaApiIntegration.new.arrival_times(route, stop_id)

    minutes_to_arrival = []

    arrival_times.each do |time|
      seconds_to_arrival = time - current_time
      minutes_to_arrival << (seconds_to_arrival / 60).floor
    end
    minutes_to_arrival
  end

  def humanize_minutes_to_arrival(minutes_to_arrival)
    string = ""
    minutes_to_arrival.each_with_index do |time, index|
      substring = ""

      if index != 0 
        substring << ", "
      end

      if time == 1
        substring << "#{time.to_s} minute"
      elsif time == 0
        substring << "less than 1 minute"
      else
        substring << "#{time.to_s} minutes"
      end

      string << substring
    end
    string
  end

  def bus(args)
    loc, dir = split_into_loc_and_dir(args)
    stop = find_closest_stop(loc, dir)    

    stop_name = stop[:stpnm]
    route = stop[:rt]
    stop_id = stop[:stpid].to_s
    direction = stop[:dir]

    arrival_times = time_until_arrival(route, stop_id)

    # check for error messages, not lack of arrival times
    if arrival_times.empty?
      bus_tracker_reply = "No arrival times for #{route} #{direction} from #{stop_name}"
    else
      bus_tracker_reply = "#{route} #{direction} from #{stop_name} in #{humanize_minutes_to_arrival(arrival_times)}"
    end

    bus_tracker_reply

  end

end