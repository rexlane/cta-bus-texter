class BusTracker

  def split_into_loc_and_dir(query)
    location = query.rpartition(' ').first
    direction = query.rpartition(' ').last.downcase
    if direction.start_with?("n")
      direction = "Northbound"
    elsif direction.start_with?("s")
      direction = "Southbound"
    elsif direction.start_with?("e")
      direction = "Eastbound"
    elsif direction.start_with?("w")
      direction = "Westbound"
    end
    return location, direction
  end

  def find_closest_stop(location, direction)
  end


  def bus(query)
  end


end