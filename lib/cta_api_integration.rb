class CtaApiIntegration

  def drop_all_stops_from_database
    BusStop.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('bus_stops')
  end

  def cta_routes_url 
    "http://www.ctabustracker.com/bustime/api/v1/getroutes?key=#{ENV['CTABUS_KEY']}"
  end

  def cta_bus_routes
    routes = []

    Nokogiri::HTML(open(cta_routes_url)).xpath("//route//rt").each do |r|
      routes << r.content
    end
    routes
  end

  def directions
    ["Northbound", "Southbound", "Eastbound", "Westbound"]
  end

  def extract_all_bus_stops
    drop_all_stops_from_database
    for route in cta_bus_routes
      for direction in directions
        BusStop.get_cta_xpath_from(route, direction)
      end
    end
  end


end
