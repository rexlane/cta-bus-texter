require 'geocoder'

class BusStop < ActiveRecord::Base
  extend Geocoder::Model::ActiveRecord
  reverse_geocoded_by :lat, :lon
  
  def self.get_cta_xpath_from(route, direction)
    url = "http://www.ctabustracker.com/bustime/api/v1/getstops?key=#{ENV['CTABUS_KEY']}&rt=#{route}&dir=#{direction}"
    Nokogiri::HTML(open(url)).xpath("//stop").each do |stop|
      create_from_cta_api_xpath(route, direction, stop)
    end
  end

  def self.create_from_cta_api_xpath(route, direction, stop) 
    create(
      :rt     =>  route,
      :dir    =>  direction,
      :stpid  =>  stop.at('stpid').content,
      :stpnm  =>  stop.at('stpnm').content,
      :lat    =>  stop.at('lat').content,
      :lon    =>  stop.at('lon').content
    )
  end
end