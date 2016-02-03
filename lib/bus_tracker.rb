require 'active_support/core_ext/time/calculations.rb'

class BusTracker
  def directions_hash
    { 'n' => 'Northbound', 's' => 'Southbound', 'w' => 'Westbound', 'e' => 'Eastbound' }
  end

  def get_location(args)
    "#{args.rpartition(' ').first} chicago"
  end

  def get_direction(args)
    direction = args.rpartition(' ').last.downcase
    return directions_hash[direction[0]] if directions_hash.key?(direction[0])
  end

  def find_closest_stop(loc, dir)
    nearest_bus_stops = BusStop.near(loc).where(dir: dir)
    # can allow for multiple routes at a single stop?
    nearest_bus_stops.first
  end

  def get_stop_info(stop)
    { stop_name: stop[:stpnm],
      route: stop[:rt],
      stop_id: stop[:stpid].to_s,
      direction: stop[:dir] }
  end

  # returns array of integers
  def calculate_time_until_arrival(current_time, arrival_times)
    minutes_to_arrival = []
    current_time = Time.parse(current_time)
    arrival_times.each do |arrival|
      arrival = Time.parse(arrival)
      seconds_to_arrival = arrival - current_time
      minutes_to_arrival << (seconds_to_arrival / 60).floor
    end
    minutes_to_arrival
  end

  # returns array of integers
  def time_until_arrival(route, stop_id)
    integration = CtaApiIntegration.new
    current_time = integration.current_time
    arrival_times = integration.arrival_times(route, stop_id)
    calculate_time_until_arrival(current_time, arrival_times)
  end

  def integer_to_words_hash
    { 1 => '1 minute', 0 => 'less than 1 minute' }
  end

  def humanize(integer)
    return integer_to_words_hash[integer] if integer_to_words_hash.key?(integer)
    "#{integer} minutes"
  end

  def humanize_minutes_to_arrival(minutes_to_arrival)
    string = ''
    minutes_to_arrival.each_with_index do |minutes, index|
      substring = humanize(minutes)
      substring.prepend(', ') if index != 0
      string << substring
    end
    string
  end

  def formulate_reply(stop_info_hash, arrivals_array)
    route = stop_info_hash[route]
    direction = stop_info_hash[direction]
    stop_name = stop_info_hash[stop_name]
    base = "Arrivals for #{route} #{direction} from #{stop_name}:"
    return "#{base} no arrival times" if arrivals_array.empty?
    "#{base} #{humanize_minutes_to_arrival(arrivals_array)}"
  end

  def bus(args)
    # returns stop database object
    stop = find_closest_stop(get_location(args), get_direction(args))

    # returns hash of stop attributes
    stop_info = get_stop_info(stop)

    # returns array of integers
    arrival_times = time_until_arrival(stop_info[route], stop_info[stop_id])

    # returns a string
    formulate_reply(stop_info, arrival_times)
  end
end
