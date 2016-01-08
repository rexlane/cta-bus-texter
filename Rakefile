require 'bundler/gem_helper'
require 'rspec/core/rake_task'
require './texter_app'
require 'sinatra/activerecord/rake'

desc 'Run all specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w(--color)
  t.verbose = false
end

task default: :spec

desc "Pull bus stop information from CTA"
task :pull_bus_stops do
  BusStop.delete_all
  ActiveRecord::Base.connection.reset_pk_sequence!('bus_stops')

  cta_base_url = "http://www.ctabustracker.com/bustime/api/v1"
  directions = ["Northbound", "Southbound", "Eastbound", "Westbound"]

  cta_routes_url = "#{cta_base_url}/getroutes?key=#{ENV['CTABUS_KEY']}"
  routes = []

  Nokogiri::HTML(open(cta_routes_url)).xpath("//route//rt").each do |r|
    routes << r.content
  end

  cta_stops_base_url = "#{cta_base_url}/getstops?key=#{ENV['CTABUS_KEY']}"

  for route in routes
    for direction in directions
      url = "#{cta_stops_base_url}&rt=#{route}&dir=#{direction}"
      Nokogiri::HTML(open(url)).xpath("//stop").each do |stop|
        @bus_stop = BusStop.create(
          :rt     =>  route,
          :dir    =>  direction,
          :stpid  =>  stop.at('stpid').content,
          :stpnm  =>  stop.at('stpnm').content,
          :lat    =>  stop.at('lat').content,
          :lon    =>  stop.at('lon').content
        )
      end
    end
  end
end