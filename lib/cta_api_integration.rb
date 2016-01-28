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

  # def cta_bus_routes
  #   [49]
  # end

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

  def current_time
    url = "http://www.ctabustracker.com/bustime/api/v1/gettime?key=#{ENV['CTABUS_KEY']}"
    cta_time = Nokogiri::HTML(open(url)).xpath("//tm").first.content
    Time.parse(cta_time)
  end
  
  def arrival_times(route, stop_id)
    url = "http://www.ctabustracker.com/bustime/api/v1/getpredictions?key=#{ENV['CTABUS_KEY']}&rt=#{route}&stpid=#{stop_id}"
    arrival_times = []
    Nokogiri::HTML(open(url)).xpath("//prd").each do |prediction|
      arrival_time = Time.parse(prediction.at("prdtm").content)
      arrival_times << arrival_time
    end
    arrival_times
  end

end
