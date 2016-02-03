class CtaApiIntegration
  def drop_all_stops_from_database
    BusStop.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('bus_stops')
  end

  def cta_base_url
    'http://www.ctabustracker.com/bustime/api/v1'
  end

  def cta_routes_url
    "#{cta_base_url}/getroutes?key=#{ENV['CTABUS_KEY']}"
  end

  def cta_bus_routes
    routes = []
    Nokogiri::HTML(open(cta_routes_url)).xpath('//route//rt').each do |r|
      routes << r.content
    end
    routes
  end

  def directions
    %w('Northbound' 'Southbound' 'Eastbound' 'Westbound')
  end

  def extract_all_bus_stops
    drop_all_stops_from_database
    cta_bus_routes.each do |route|
      directions.each do |direction|
        BusStop.get_cta_xpath_from(route, direction)
      end
    end
  end

  def current_time
    url = "#{cta_base_url}/gettime?key=#{ENV['CTABUS_KEY']}"
    Nokogiri::HTML(open(url)).xpath('//tm').first.content
  end

  def arrival_times(route, stop_id)
    url = "#{cta_base_url}/getpredictions?key=#{ENV['CTABUS_KEY']}&rt=#{route}&stpid=#{stop_id}"
    arrival_times = []
    Nokogiri::HTML(open(url)).xpath('//prd').each do |prediction|
      arrival_times << prediction.at('prdtm').content
    end
    arrival_times
  end
end
